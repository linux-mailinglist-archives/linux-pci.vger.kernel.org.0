Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C05B467F
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiIJNdV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 09:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJNdU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 09:33:20 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46A44545;
        Sat, 10 Sep 2022 06:33:18 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id d9ff3f23ec2aa29d; Sat, 10 Sep 2022 15:33:17 +0200
Received: from kreacher.localnet (unknown [213.134.169.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 71AC066D496;
        Sat, 10 Sep 2022 15:33:16 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        whitehat002 <hackyzh002@gmail.com>
Subject: Re: [PATCH] PCI/ACPI: do not reference a pci device after it has been released
Date:   Sat, 10 Sep 2022 15:33:15 +0200
Message-ID: <5873315.lOV4Wx5bFT@kreacher>
In-Reply-To: <Yxwjq3PgEf60B9Vk@kroah.com>
References: <20220428142854.1065953-1-gregkh@linuxfoundation.org> <5870387.lOV4Wx5bFT@kreacher> <Yxwjq3PgEf60B9Vk@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.62
X-CLIENT-HOSTNAME: 213.134.169.62
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtjedgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddufedrudefgedrudeiledriedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledriedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthht
 oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrtghkhiiihhdttddvsehgmhgrihhlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday, September 10, 2022 7:42:03 AM CEST Greg Kroah-Hartman wrote:
> On Fri, Sep 09, 2022 at 11:18:46PM +0200, Rafael J. Wysocki wrote:
> > On Friday, September 9, 2022 9:42:53 AM CEST Greg Kroah-Hartman wrote:
> > > On Mon, Jun 27, 2022 at 06:37:06PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Jun 27, 2022 at 5:07 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Apr 28, 2022 at 10:30:38PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Thu, Apr 28, 2022 at 10:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 28, 2022 at 6:22 PM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Apr 28, 2022 at 10:58:58AM -0500, Bjorn Helgaas wrote:
> > > > > > > > > On Thu, Apr 28, 2022 at 04:28:53PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > > In acpi_get_pci_dev(), the debugging message for when a PCI bridge is
> > > > > > > > > > not found uses a pointer to a pci device whose reference has just been
> > > > > > > > > > dropped.  The chance that this really is a device that is now been
> > > > > > > > > > removed from the system is almost impossible to happen, but to be safe,
> > > > > > > > > > let's print out the debugging message based on the acpi root device
> > > > > > > > > > which we do have a valid reference to at the moment.
> > > > > > > > >
> > > > > > > > > This code was added by 497fb54f578e ("ACPI / PCI: Fix NULL pointer
> > > > > > > > > dereference in acpi_get_pci_dev() (rev. 2)").  Not sure if it's worth
> > > > > > > > > a Fixes: tag.
> > > > > > > >
> > > > > > > > Can't hurt, I'll add it for the v2 based on this review.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > acpi_get_pci_dev() is used by only five callers, three of which are
> > > > > > > > > video/backlight related.  I'm always skeptical of one-off interfaces
> > > > > > > > > like this, but I don't know enough to propose any refactoring or other
> > > > > > > > > alternatives.
> > > > > > > > >
> > > > > > > > > I'll leave this for Rafael, but if I were applying I would silently
> > > > > > > > > touch up the subject to match convention:
> > > > > > > > >
> > > > > > > > >   PCI/ACPI: Do not reference PCI device after it has been released
> > > > > > > >
> > > > > > > > Much simpler, thanks.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > > > > > > Cc: Len Brown <lenb@kernel.org>
> > > > > > > > > > Cc: linux-pci@vger.kernel.org
> > > > > > > > > > Cc: linux-acpi@vger.kernel.org
> > > > > > > > > > Reported-by: whitehat002 <hackyzh002@gmail.com>
> > > > > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/acpi/pci_root.c | 3 ++-
> > > > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > > > > > > > > index 6f9e75d14808..ecda378dbc09 100644
> > > > > > > > > > --- a/drivers/acpi/pci_root.c
> > > > > > > > > > +++ b/drivers/acpi/pci_root.c
> > > > > > > > > > @@ -303,7 +303,8 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> > > > > > > > > >              * case pdev->subordinate will be NULL for the parent.
> > > > > > > > > >              */
> > > > > > > > > >             if (!pbus) {
> > > > > > > > > > -                   dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > > > > > > > > > +                   dev_dbg(&root->device->dev,
> > > > > > > > > > +                           "dev %d, function %d is not a PCI-to-PCI bridge\n", dev, fn);
> > > > > > > > >
> > > > > > > > > This should use "%02x.%d" to be consistent with the dev_set_name() in
> > > > > > > > > pci_setup_device().
> > > > > > > >
> > > > > > > > Ah, missed that, will change it and send out a new version tomorrow.
> > > > > > >
> > > > > > > I would make the change below (modulo the gmail-induced wthite space
> > > > > > > breakage), though.
> > > > > >
> > > > > > That said ->
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/acpi/pci_root.c |    5 +++--
> > > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > Index: linux-pm/drivers/acpi/pci_root.c
> > > > > > > ===================================================================
> > > > > > > --- linux-pm.orig/drivers/acpi/pci_root.c
> > > > > > > +++ linux-pm/drivers/acpi/pci_root.c
> > > > > > > @@ -295,8 +295,6 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
> > > > > > >              break;
> > > > > > >
> > > > > > >          pbus = pdev->subordinate;
> > > > > > > -        pci_dev_put(pdev);
> > > > > > > -
> > > > > > >          /*
> > > > > > >           * This function may be called for a non-PCI device that has a
> > > > > > >           * PCI parent (eg. a disk under a PCI SATA controller).  In that
> > > > > > > @@ -304,9 +302,12 @@ struct pci_dev *acpi_get_pci_dev(acpi_ha
> > > > > > >           */
> > > > > > >          if (!pbus) {
> > > > > > >              dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> > > > > > > +            pci_dev_put(pdev);
> > > > > > >              pdev = NULL;
> > > > > > >              break;
> > > > > > >          }
> > > > > > > +
> > > > > > > +        pci_dev_put(pdev);
> > > > > >
> > > > > > -> we are going to use pbus after this and it is pdev->subordinate
> > > > > > which cannot survive without pdev AFAICS.
> > > > > >
> > > > > > Are we not concerned about this case?
> > > > >
> > > > > Good point.
> > > > >
> > > > > whitehat002, any ideas?  You found this issue but it really looks like
> > > > > it is not anything that can ever be hit, so how far do you want to go to
> > > > > unwind it?
> > > > 
> > > > I have an idea, sorry for the delay here.
> > > > 
> > > > I should be ready to post something tomorrow.
> > > 
> > > Was this ever posted?
> > 
> > No, it wasn't.  Sorry for the glacial pace here.
> > 
> > So the idea is based on the observation that the PCI device returned by the current
> > code in acpi_get_pci_dev() needs to be registered, so if it corresponds to an ACPI
> > device object, the struct acpi_device representing it must be registered too and,
> > moreover, it should be the ACPI companion of that PCI device.  Thus it should be
> > sufficient to look for it in the ACPI device object's list of physical nodes
> > corresponding to it.  Hence, the patch below.
> > 
> > I actually can't test it right now (or even compile it for that matter), but
> > I'll put it in order tomorrow.
> 
> The idea looks sane to me, let me know if testing works or not, thanks!

The patch sent previously had a few build issues, so I've just officially
posted a version of it that builds:

https://patchwork.kernel.org/project/linux-acpi/patch/2661914.mvXUDI8C0e@kreacher/

To test it, I've applied the appended extra debug patch and checked that the output
from it is the same before and after the change above.  It is for me.

---
 drivers/acpi/scan.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2537,6 +2537,19 @@ static void __init acpi_get_spcr_uart_ad
 
 static bool acpi_scan_initialized;
 
+#include <linux/pci.h>
+
+static int pci_dev_check(struct device *dev, void *not_used)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+	struct pci_dev *pci_dev = acpi_get_pci_dev(adev->handle);
+
+	if (pci_dev)
+		dev_info(&adev->dev, "%s: %s\n", __func__, dev_name(&pci_dev->dev));
+
+	return 0;
+}
+
 void __init acpi_scan_init(void)
 {
 	acpi_status status;
@@ -2603,6 +2616,8 @@ void __init acpi_scan_init(void)
 
 	acpi_scan_initialized = true;
 
+	acpi_bus_for_each_dev(pci_dev_check, NULL);
+
 unlock:
 	mutex_unlock(&acpi_scan_lock);
 }



