Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E54A7C03
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 00:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348184AbiBBX4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 18:56:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32800 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiBBX4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 18:56:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B9C3B81038;
        Wed,  2 Feb 2022 23:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5CEC004E1;
        Wed,  2 Feb 2022 23:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643846160;
        bh=VYKWNJ13o28HJ6kkZTai5gFkSoXL6VWNwk791MCkgXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JXBznAehLdmH39bfydGEumyDD6TIrVTQCUrsuyTzqAWWyQ6BygNXtk7dJhUZxBQYF
         BTBXo623GCuc+DXbETm0fro4lf36v6LCvF14E7y68be1a8U01SqK7moAL0DruiGdZy
         x0ihBIXn0bkKcvpP6/ARRguyAwN83zxE4zHWQr8h62YkYUcWhPq5LNElIkyiiKjLBs
         s5Rc9KgzAvopa0TwR3upz0i+6OZdUexwg4mp/ozjfuUFbfs3vmpFG8Ynm6pBFxUxyt
         llToOS/cqlGpvxxoDLDMqu44ydKKeoN+Bj+2T/8rz0d/k43GW2p/uf8IXkQCU7uYMi
         SVqXNhjkMcEFw==
Date:   Wed, 2 Feb 2022 17:55:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        mariusz.tkaczyk@linux.intel.com, lukas@wunner.de, pavel@ucw.cz,
        linux-cxl@vger.kernel.org, martin.petersen@oracle.com,
        James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v2 1/3] Add support for seven more indicators in
 enclosure driver
Message-ID: <20220202235558.GA54005@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d71f2483ed6cb6ea74a267301982c14e6bfa79a7.1643822289.git.stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Follow subject line convention (also applies to other patches):

  $ git log --oneline drivers/misc/enclosure.c
  714f1af14bb0 misc: enclosure: replace snprintf in show functions with sysfs_emit
  6a57251c70a4 misc: enclosure: Update enclosure_remove_device() documentation to match reality
  82f5b473d91a misc: enclosure: Fix some kerneldoc anomalies
  529244bd1afc scsi: enclosure: Fix stale device oops with hot replug
  e3575c1201f0 misc: enclosure: Use struct_size() in kzalloc()
  750b54deb569 misc: enclosure: Remove unnecessary error check

I don't think "seven" is really relevant for the subject or even the
commit log since you list them all anyway.

On Wed, Feb 02, 2022 at 11:59:11AM -0600, Stuart Hayes wrote:
> This patch adds support for seven additional indicators (ok, rebuild,
> prdfail, hotspare, ica, ifa, disabled) to the enclosure driver, which
> currently only supports three (fault, active, locate). It also reduces
> duplicated code for the set and show functions for the sysfs attributes
> for all of the indicators, and allows users of the driver to provide
> common get_led and set_led callbacks to control all indicators (though
> it continues to support the existing callbacks for the three currently
> supported indicators, so it does not require any changes to code that
> already uses the enclosure driver).

This restructures things (replacing get_component_fault(),
set_component_fault(), etc with attributes) and adds things (the new
indicators and also maybe the .get_led() and .set_led() hooks).  It
would be nice to split all those into separate patches.

Also consider using imperative mood:
  https://chris.beams.io/posts/git-commit/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v5.16#n134

A few more minor comments below.

> @@ -0,0 +1,14 @@
> +What:		/sys/class/enclosure/<enclosure>/<component>/rebuild
> +What:		/sys/class/enclosure/<enclosure>/<component>/disabled
> +What:		/sys/class/enclosure/<enclosure>/<component>/hotspare
> +What:		/sys/class/enclosure/<enclosure>/<component>/ica
> +What:		/sys/class/enclosure/<enclosure>/<component>/ifa
> +What:		/sys/class/enclosure/<enclosure>/<component>/ok
> +What:		/sys/class/enclosure/<enclosure>/<component>/prdfail
> +Date:		February 2022
> +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
> +Description:
> +		(RW) Get or set the indicator (1 is on, 0 is off) that
> +		corresponds to the attribute name, for a component in an
> +		enclosure. The "ica" and "ifa" states are "in critical
> +		array" and "in failed array".

What's "prdfail"?

> diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
> index 1b010d9267c9..485d6a3c655b 100644
> --- a/drivers/misc/enclosure.c
> +++ b/drivers/misc/enclosure.c
> @@ -473,30 +473,6 @@ static const char *const enclosure_type[] = {
>  	[ENCLOSURE_COMPONENT_ARRAY_DEVICE] = "array device",
>  };
>  
> -static ssize_t get_component_fault(struct device *cdev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -	struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -
> -	if (edev->cb->get_fault)
> -		edev->cb->get_fault(edev, ecomp);
> -	return sysfs_emit(buf, "%d\n", ecomp->fault);
> -}
> -
> -static ssize_t set_component_fault(struct device *cdev,
> -				   struct device_attribute *attr,
> -				   const char *buf, size_t count)
> -{
> -	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -	struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -	int val = simple_strtoul(buf, NULL, 0);
> -
> -	if (edev->cb->set_fault)
> -		edev->cb->set_fault(edev, ecomp, val);
> -	return count;
> -}
> -
>  static ssize_t get_component_status(struct device *cdev,
>  				    struct device_attribute *attr,char *buf)
>  {
> @@ -531,54 +507,6 @@ static ssize_t set_component_status(struct device *cdev,
>  		return -EINVAL;
>  }
>  
> -static ssize_t get_component_active(struct device *cdev,
> -				    struct device_attribute *attr, char *buf)
> -{
> -	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -	struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -
> -	if (edev->cb->get_active)
> -		edev->cb->get_active(edev, ecomp);
> -	return sysfs_emit(buf, "%d\n", ecomp->active);
> -}
> -
> -static ssize_t set_component_active(struct device *cdev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -	struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -	int val = simple_strtoul(buf, NULL, 0);
> -
> -	if (edev->cb->set_active)
> -		edev->cb->set_active(edev, ecomp, val);
> -	return count;
> -}
> -
> -static ssize_t get_component_locate(struct device *cdev,
> -				    struct device_attribute *attr, char *buf)
> -{
> -	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -	struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -
> -	if (edev->cb->get_locate)
> -		edev->cb->get_locate(edev, ecomp);
> -	return sysfs_emit(buf, "%d\n", ecomp->locate);
> -}
> -
> -static ssize_t set_component_locate(struct device *cdev,
> -				    struct device_attribute *attr,
> -				    const char *buf, size_t count)
> -{
> -	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> -	struct enclosure_component *ecomp = to_enclosure_component(cdev);
> -	int val = simple_strtoul(buf, NULL, 0);
> -
> -	if (edev->cb->set_locate)
> -		edev->cb->set_locate(edev, ecomp, val);
> -	return count;
> -}
> -
>  static ssize_t get_component_power_status(struct device *cdev,
>  					  struct device_attribute *attr,
>  					  char *buf)
> @@ -641,29 +569,136 @@ static ssize_t get_component_slot(struct device *cdev,
>  	return sysfs_emit(buf, "%d\n", slot);
>  }
>  
> -static DEVICE_ATTR(fault, S_IRUGO | S_IWUSR, get_component_fault,
> -		    set_component_fault);
> +/*
> + * callbacks for attrs using enum enclosure_component_setting (LEDs)
> + */
> +static ssize_t led_show(struct device *cdev,
> +			enum enclosure_component_led led,
> +			char *buf)
> +{
> +	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> +	struct enclosure_component *ecomp = to_enclosure_component(cdev);
> +
> +	if (edev->cb->get_led)
> +		edev->cb->get_led(edev, ecomp, led);
> +	else

The switch is technically one statement, but it's so long that I think
it really needs braces around it.

> +		/*
> +		 * support old callbacks for fault/active/locate
> +		 */
> +		switch (led) {
> +		case ENCLOSURE_LED_FAULT:
> +			if (edev->cb->get_fault) {
> +				edev->cb->get_fault(edev, ecomp);
> +				ecomp->led[led] = ecomp->fault;
> +			}
> +			break;
> +		case ENCLOSURE_LED_ACTIVE:
> +			if (edev->cb->get_active) {
> +				edev->cb->get_active(edev, ecomp);
> +				ecomp->led[led] = ecomp->active;
> +			}
> +			break;
> +		case ENCLOSURE_LED_LOCATE:
> +			if (edev->cb->get_locate) {
> +				edev->cb->get_locate(edev, ecomp);
> +				ecomp->led[led] = ecomp->locate;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +
> +	return sysfs_emit(buf, "%d\n", ecomp->led[led]);
> +}
> +
> +static ssize_t led_set(struct device *cdev,
> +		       enum enclosure_component_led led,
> +		       const char *buf, size_t count)
> +{
> +	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
> +	struct enclosure_component *ecomp = to_enclosure_component(cdev);
> +	int err, val;
> +
> +	err = kstrtoint(buf, 0, &val);
> +	if (err)
> +		return err;
> +
> +	if (edev->cb->set_led)
> +		edev->cb->set_led(edev, ecomp, led, val);
> +	else

Same here.  Or you could just return early for the cb->set_led case
and unindent the below.

> +		/*
> +		 * support old callbacks for fault/active/locate
> +		 */
> +		switch (led) {
> +		case ENCLOSURE_LED_FAULT:
> +			if (edev->cb->set_fault)
> +				edev->cb->set_fault(edev, ecomp, val);
> +			break;
> +		case ENCLOSURE_LED_ACTIVE:
> +			if (edev->cb->set_active)
> +				edev->cb->set_active(edev, ecomp, val);
> +			break;
> +		case ENCLOSURE_LED_LOCATE:
> +			if (edev->cb->set_locate)
> +				edev->cb->set_locate(edev, ecomp, val);
> +			break;
> +		default:
> +			break;
> +		}

I guess you rely on the callbacks to set ecomp->led[led] (or
ecomp->fault, etc)?

Maybe do the "ecomp->led[led] = ecomp->fault" bits here instead of in
led_show() so that crashdumps will show the same info regardless of
whether led_show() has been run?  ...

Oh, never mind, I see that you only ever update led[led] in the
.get_led() callbacks.  In that case, why do you even *store* the
result in led[led]?  Couldn't you just return it from .get_led()?

> +	return count;
> +}
> +
> +#define LED_ATTR_RW(led_attr, led)					\
> +static ssize_t led_attr##_show(struct device *cdev,			\
> +			       struct device_attribute *attr,		\
> +			       char *buf)				\
> +{									\
> +	return led_show(cdev, led, buf);				\
> +}									\
> +static ssize_t led_attr##_store(struct device *cdev,			\
> +				struct device_attribute *attr,		\
> +				const char *buf, size_t count)		\
> +{									\
> +	return led_set(cdev, led, buf, count);				\
> +}									\
> +static DEVICE_ATTR_RW(led_attr)
> +
>  static DEVICE_ATTR(status, S_IRUGO | S_IWUSR, get_component_status,
>  		   set_component_status);
> -static DEVICE_ATTR(active, S_IRUGO | S_IWUSR, get_component_active,
> -		   set_component_active);
> -static DEVICE_ATTR(locate, S_IRUGO | S_IWUSR, get_component_locate,
> -		   set_component_locate);
>  static DEVICE_ATTR(power_status, S_IRUGO | S_IWUSR, get_component_power_status,
>  		   set_component_power_status);
>  static DEVICE_ATTR(type, S_IRUGO, get_component_type, NULL);
>  static DEVICE_ATTR(slot, S_IRUGO, get_component_slot, NULL);
> +LED_ATTR_RW(fault, ENCLOSURE_LED_FAULT);
> +LED_ATTR_RW(active, ENCLOSURE_LED_ACTIVE);
> +LED_ATTR_RW(locate, ENCLOSURE_LED_LOCATE);
> +LED_ATTR_RW(ok, ENCLOSURE_LED_OK);
> +LED_ATTR_RW(rebuild, ENCLOSURE_LED_REBUILD);
> +LED_ATTR_RW(prdfail, ENCLOSURE_LED_PRDFAIL);
> +LED_ATTR_RW(hotspare, ENCLOSURE_LED_HOTSPARE);
> +LED_ATTR_RW(ica, ENCLOSURE_LED_ICA);
> +LED_ATTR_RW(ifa, ENCLOSURE_LED_IFA);
> +LED_ATTR_RW(disabled, ENCLOSURE_LED_DISABLED);
>  
>  static struct attribute *enclosure_component_attrs[] = {
>  	&dev_attr_fault.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_active.attr,
>  	&dev_attr_locate.attr,
> +	&dev_attr_ok.attr,
> +	&dev_attr_rebuild.attr,
> +	&dev_attr_prdfail.attr,
> +	&dev_attr_hotspare.attr,
> +	&dev_attr_ica.attr,
> +	&dev_attr_ifa.attr,
> +	&dev_attr_disabled.attr,
>  	&dev_attr_power_status.attr,
>  	&dev_attr_type.attr,
>  	&dev_attr_slot.attr,
>  	NULL
>  };
> +

Spurious diff?  I see both with and without this blank line, but seems
more common without.

>  ATTRIBUTE_GROUPS(enclosure_component);

>  
>  static int __init enclosure_init(void)
> diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
> index 1c630e2c2756..98dd0f05efb7 100644
> --- a/include/linux/enclosure.h
> +++ b/include/linux/enclosure.h
> @@ -49,6 +49,20 @@ enum enclosure_component_setting {
>  	ENCLOSURE_SETTING_BLINK_B_OFF_ON = 7,
>  };
>  
> +enum enclosure_component_led {
> +	ENCLOSURE_LED_FAULT,
> +	ENCLOSURE_LED_ACTIVE,
> +	ENCLOSURE_LED_LOCATE,
> +	ENCLOSURE_LED_OK,
> +	ENCLOSURE_LED_REBUILD,
> +	ENCLOSURE_LED_PRDFAIL,
> +	ENCLOSURE_LED_HOTSPARE,
> +	ENCLOSURE_LED_ICA,
> +	ENCLOSURE_LED_IFA,
> +	ENCLOSURE_LED_DISABLED,
> +	ENCLOSURE_LED_MAX,
> +};
> +
>  struct enclosure_device;
>  struct enclosure_component;
>  struct enclosure_component_callbacks {
> @@ -72,6 +86,13 @@ struct enclosure_component_callbacks {
>  	int (*set_locate)(struct enclosure_device *,
>  			  struct enclosure_component *,
>  			  enum enclosure_component_setting);
> +	void (*get_led)(struct enclosure_device *edev,
> +			struct enclosure_component *ecomp,
> +			enum enclosure_component_led);
> +	int (*set_led)(struct enclosure_device *edev,
> +		       struct enclosure_component *ecomp,
> +		       enum enclosure_component_led,
> +		       enum enclosure_component_setting);
>  	void (*get_power_status)(struct enclosure_device *,
>  				 struct enclosure_component *);
>  	int (*set_power_status)(struct enclosure_device *,
> @@ -90,6 +111,7 @@ struct enclosure_component {
>  	int fault;
>  	int active;
>  	int locate;
> +	int led[ENCLOSURE_LED_MAX];
>  	int slot;
>  	enum enclosure_status status;
>  	int power_status;
> -- 
> 2.31.1
> 
