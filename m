Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2442F7D8720
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjJZRDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 13:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZRDh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 13:03:37 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA09194;
        Thu, 26 Oct 2023 10:03:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 60db24a9da3562ba; Thu, 26 Oct 2023 19:03:31 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5F8546673F2;
        Thu, 26 Oct 2023 19:03:31 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/4] PCI: Make d3cold_allowed sysfs attribute read only
Date:   Thu, 26 Oct 2023 19:03:31 +0200
Message-ID: <2717722.mvXUDI8C0e@kreacher>
In-Reply-To: <20231025020546.504-2-mario.limonciello@amd.com>
References: <20231025020546.504-1-mario.limonciello@amd.com> <20231025020546.504-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghm
 ugdrtghomhdprhgtphhtthhopefuhhihrghmqdhsuhhnuggrrhdrufdqkhesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, October 25, 2023 4:05:43 AM CEST Mario Limonciello wrote:
> Before kernel 3.6 D3cold was considered "opt-in" for PCIe devices.
> Userspace was able to opt PCIe devices into d3cold support by using
> the `d3cold_allowed` sysfs attribute. The policy changed to default
> to enabled with commit 4f9c1397e2e8 ("PCI/PM: Enable D3/D3cold by
> default for most devices").  The sysfs file remains however and
> can potentially allow userspace to prevent the SoC from getting into
> the deepest sleep state on modern systems.
> 
> For debugging purposes `pcie_port_pm=` can be used to control whether
> a PCI port will go into D3cold and runtime PM can be turned off by
> `/sys/bus/pci/devices/*/power/control` on PCI end points.
> 
> Change the sysfs attribute to a noop that ignores the input when written
> and shows a warning. Simplify the internal kernel logic to drop
> `d3cold_allowed`.
> 
> Link: https://lore.kernel.org/linux-pci/20230918132424.GA11357@wunner.de/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I'm not aware of anyone using this sysfs i/f in practice, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> Changes from previous submission:
>  * Update commit message
>  * Roll into series for D3 related handling
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  4 ++--
>  drivers/pci/pci-acpi.c                  |  2 +-
>  drivers/pci/pci-sysfs.c                 | 14 ++------------
>  drivers/pci/pci.c                       |  3 +--
>  include/linux/pci.h                     |  1 -
>  5 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..b5db141dfee6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -283,8 +283,8 @@ Description:
>  		device will never be put into D3Cold state.  If it is set, the
>  		device may be put into D3Cold state if other requirements are
>  		satisfied too.  Reading this attribute will show the current
> -		value of d3cold_allowed bit.  Writing this attribute will set
> -		the value of d3cold_allowed bit.
> +		value of no_d3cold bit.
> +		Writing to this attribute is deprecated and will do nothing.
>  
>  What:		/sys/bus/pci/devices/.../sriov_totalvfs
>  Date:		November 2012
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 05b7357bd258..a05350a4e49c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  {
>  	int acpi_state, d_max;
>  
> -	if (pdev->no_d3cold || !pdev->d3cold_allowed)
> +	if (pdev->no_d3cold)
>  		d_max = ACPI_STATE_D3_HOT;
>  	else
>  		d_max = ACPI_STATE_D3_COLD;
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5e741a05cf2c..52ed5a55a371 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -523,17 +523,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
>  				    struct device_attribute *attr,
>  				    const char *buf, size_t count)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	unsigned long val;
> -
> -	if (kstrtoul(buf, 0, &val) < 0)
> -		return -EINVAL;
> -
> -	pdev->d3cold_allowed = !!val;
> -	pci_bridge_d3_update(pdev);
> -
> -	pm_runtime_resume(dev);
> -
> +	dev_warn_once(dev, "pci: writing to d3cold_allowed is deprecated\n");
>  	return count;
>  }
>  
> @@ -541,7 +531,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
> +	return sysfs_emit(buf, "%u\n", !pdev->no_d3cold);
>  }
>  static DEVICE_ATTR_RW(d3cold_allowed);
>  #endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..8c5a6f68f63d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3067,7 +3067,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
>  	bool *d3cold_ok = data;
>  
>  	if (/* The device needs to be allowed to go D3cold ... */
> -	    dev->no_d3cold || !dev->d3cold_allowed ||
> +	    dev->no_d3cold ||
>  
>  	    /* ... and if it is wakeup capable to do so from D3cold. */
>  	    (device_may_wakeup(&dev->dev) &&
> @@ -3204,7 +3204,6 @@ void pci_pm_init(struct pci_dev *dev)
>  	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
>  	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
>  	dev->bridge_d3 = pci_bridge_d3_possible(dev);
> -	dev->d3cold_allowed = true;
>  
>  	dev->d1_support = false;
>  	dev->d2_support = false;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8c7c2c3c6c65..5f4ed71d31f5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -376,7 +376,6 @@ struct pci_dev {
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>  	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
>  	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
> -	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
>  	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
>  						   decoding during BAR sizing */
>  	unsigned int	wakeup_prepared:1;
> 




