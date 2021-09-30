Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1C41D186
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 04:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347875AbhI3Ckd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 22:40:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:59232 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347849AbhI3Ckd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 22:40:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212341575"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="212341575"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 19:38:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="555319477"
Received: from pgupadra-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.0.91])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 19:38:49 -0700
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     Dan Williams <dan.j.williams@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930014229.GA447956@rowland.harvard.edu>
 <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f9b7cf97-0a14-1c80-12ab-23213ec2f4f2@linux.intel.com>
Date:   Wed, 29 Sep 2021 19:38:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iiEC3B2i81evZpLP+XHa8dLkfgWmrY7HocORwP8FMPZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/29/21 6:55 PM, Dan Williams wrote:
>> Also, you ignored the usb_[de]authorize_interface() functions and
>> their friends.
> Ugh, yes.

I did not change it because I am not sure about the interface vs device
dependency.

I think following change should work.

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f57b5a7a90ca..84969732d09c 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -334,7 +334,7 @@ static int usb_probe_interface(struct device *dev)
  	if (udev->dev.authorized == false) {
  		dev_err(&intf->dev, "Device is not authorized for usage\n");
  		return error;
-	} else if (intf->authorized == 0) {
+	} else if (intf->dev.authorized == 0) {
  		dev_err(&intf->dev, "Interface %d is not authorized for usage\n",
  				intf->altsetting->desc.bInterfaceNumber);
  		return error;
@@ -546,7 +546,7 @@ int usb_driver_claim_interface(struct usb_driver *driver,
  		return -EBUSY;

  	/* reject claim if interface is not authorized */
-	if (!iface->authorized)
+	if (!iface->dev.authorized)
  		return -ENODEV;

  	dev->driver = &driver->drvwrap.driver;
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 47548ce1cfb1..ab3c8d1e4db9 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1791,9 +1791,9 @@ void usb_deauthorize_interface(struct usb_interface *intf)

  	device_lock(dev->parent);

-	if (intf->authorized) {
+	if (intf->dev.authorized) {
  		device_lock(dev);
-		intf->authorized = 0;
+		intf->dev.authorized = 0;
  		device_unlock(dev);

  		usb_forced_unbind_intf(intf);
@@ -1811,9 +1811,9 @@ void usb_authorize_interface(struct usb_interface *intf)
  {
  	struct device *dev = &intf->dev;

-	if (!intf->authorized) {
+	if (!intf->dev.authorized) {
  		device_lock(dev);
-		intf->authorized = 1; /* authorize interface */
+		intf->dev.authorized = 1; /* authorize interface */
  		device_unlock(dev);
  	}
  }
@@ -2069,7 +2069,6 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
  		intfc = cp->intf_cache[i];
  		intf->altsetting = intfc->altsetting;
  		intf->num_altsetting = intfc->num_altsetting;
-		intf->authorized = !!HCD_INTF_AUTHORIZED(hcd);
  		kref_get(&intfc->ref);

  		alt = usb_altnum_to_altsetting(intf, 0);
@@ -2101,6 +2100,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
  		INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
  		intf->minor = -1;
  		device_initialize(&intf->dev);
+		intf->dev.authorized = !!HCD_INTF_AUTHORIZED(hcd);
  		pm_runtime_no_callbacks(&intf->dev);
  		dev_set_name(&intf->dev, "%d-%s:%d.%d", dev->bus->busnum,
  				dev->devpath, configuration, ifnum);
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 3d63e345d0a0..666eeb80ff29 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -1160,9 +1160,7 @@ static DEVICE_ATTR_RO(supports_autosuspend);
  static ssize_t interface_authorized_show(struct device *dev,
  		struct device_attribute *attr, char *buf)
  {
-	struct usb_interface *intf = to_usb_interface(dev);
-
-	return sprintf(buf, "%u\n", intf->authorized);
+	return sprintf(buf, "%u\n", dev->authorized);
  }

  /*
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 796df4068e94..1e41453c63cb 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -195,8 +195,6 @@ usb_find_last_int_out_endpoint(struct usb_host_interface *alt,
   *	has been deferred.
   * @needs_binding: flag set when the driver should be re-probed or unbound
   *	following a reset or suspend operation it doesn't support.
- * @authorized: This allows to (de)authorize individual interfaces instead
- *	a whole device in contrast to the device authorization.
   * @dev: driver model's view of this device
   * @usb_dev: if an interface is bound to the USB major, this will point
   *	to the sysfs representation for that device.
@@ -252,7 +250,6 @@ struct usb_interface {
  	unsigned needs_altsetting0:1;	/* switch to altsetting 0 is pending */
  	unsigned needs_binding:1;	/* needs delayed unbind/rebind */
  	unsigned resetting_device:1;	/* true: bandwidth alloc after reset */
-	unsigned authorized:1;		/* used for interface authorization */

  	struct device dev;		/* interface specific device info */
  	struct device *usb_dev;
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
