Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2AD664490
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 16:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbjAJPYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 10:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjAJPYM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 10:24:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18251EE20;
        Tue, 10 Jan 2023 07:24:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C68761760;
        Tue, 10 Jan 2023 15:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3D8C4339B;
        Tue, 10 Jan 2023 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673364250;
        bh=vNXvpg+np4GSOsa+P5SDUwDQV/vK1AREO780HlftZ0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BAEk+PEw7sy82Y34pq1cQumvGj/7e0ZyFPqfKW+/PHZTB1az8tYKq8py/hE/bKSXZ
         nuAJM8KryiVWShD+wU70U4wVW4P/Y9N/OTfvtA5ufConrrtsarFd5wfHBaAdjyXHae
         FSo3dsDUF2TDuSgbncX6D4M1Re+aaXo6cwQmwYupcMotLdt0s0/7Ubi1FvHT0G1yWQ
         teQgTp9jel4hLg4rt31rlUG27nGo13d7JjS1mPyg8WrhNw4LtHSlAiZ3SevBvigwDr
         vHFz2pRTqcJ3GixWD67lzDH6v6xoD5L9uduAbfziVAtlFPDDPjwEJjMLMGZSNAQRlv
         2NNWfqJA3NB9w==
Date:   Tue, 10 Jan 2023 09:24:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mad Horse <equu@openmail.cc>
Cc:     lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] pci: Add functions to match pci dev or driver against OF
 DT node
Message-ID: <20230110152408.GA1503126@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4e2fed-383d-829d-8a2a-9239768ccd94@openmail.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

On Sat, Jan 07, 2023 at 11:14:14PM +0800, Mad Horse wrote:
> Currently, there seems no mechanism to check whether a compatibility
> string within an OF DT node for a PCI device (whose spec is at
> https://www.devicetree.org/open-firmware/bindings/pci/ ) matches the
> vendor and device id of either the PCI device installed on the
> corresponding location or the driver suggested by the compatibility
> string, which can cause, for example, that an nvram cell defined
> within an OF DT node for a driver may be erroneously applied to a
> replaced device which should be powered with another driver capable to
> accept an nvram cell with the same name, causing the driver
> malfunctional or even kernel panic.
> 
> In order to resolve such issue, this patch introduces a function to
> decode a compatibility string into a struct pci_device_id, which could
> further be matched against PCI devices or drivers, as well as
> functions to match a compatibility string or OF DT node against PCI
> devices or drivers.
> 
> PCI drivers can then call these functions to check whether an OF DT
> node matches themselves during driver enumeration, in order to accept
> additional data provided by the node or ignore them when
> incompatible.

Thanks for your patch!  Hints for v2:

  - CC Rob Herring <robh@kernel.org> for of.c changes (maybe we
    should update MAINTAINERS to suggest this?)

  - Follow existing style of subject lines and commit logs; use "git
    log drivers/pci", "git log --oneline drivers/pci", see
    https://chris.beams.io/posts/git-commit/

  - Post this patch along with users of the new functions.  We don't
    normally add new code until there are actual users of it.

  - The patch itself looks whitespace-damaged and doesn't apply
    cleanly to v6.2-rc1:
      $ git am m/20230107_equu_pci_add_functions_to_match_pci_dev_or_driver_against_of_dt_node.mbx
      Applying: pci: Add functions to match pci dev or driver against OF DT node
      error: corrupt patch at line 14

A few more comments below.

Bjorn

> Signed-off-by: Edward Chow <equu@openmail.cc>
> ---
> drivers/pci/of.c | 304 +++++++++++++++++++++++++++++++++++++++
> drivers/pci/pci-driver.c | 5 -
> drivers/pci/pci.h | 56 ++++++++
> include/linux/of_pci.h | 25 ++++
> include/linux/pci.h | 6 +
> 5 files changed, 391 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..5d69bef67ef1 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -13,6 +13,8 @@
> #include <linux/of_irq.h>
> #include <linux/of_address.h>
> #include <linux/of_pci.h>
> +#include <linux/string.h>
> +#include <linux/kstrtox.h>
> #include "pci.h"
> #ifdef CONFIG_PCI
> @@ -251,6 +253,308 @@ void of_pci_check_probe_only(void)
> }
> EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
> +/**
> + * of_pci_compat_to_device_id() - Decode an OF compatibility string into a
> + * pci_device_id structure.
> + * @compat: the compatibility string to decode, could be NULL
> + * @id: pointer to a struct pci_device_id, to store the result
> + * @rev: pointer to output revision info, PCI_ANY_ID if no revision in
> @compat
> + * @req_pcie: pointer to output whether @compat mandates PCI-E
> compatibility

"PCIe" is the conventional spelling.

> + * returns 0 when success, -EINVAL when failed.
> + */
> +int of_pci_compat_to_device_id(const char *compat, struct pci_device_id
> *id,
> + __u32 *rev, __u32 *req_pcie)
> +{
> + union {
> + __u8 u8;
> + __u16 u16;
> + __u32 u32;

Use "u8", "u16", "u32" typedefs instead of "__u8" etc.; you can see
this by looking at other code in of.c.

> + } res = {0};
> + *req_pcie = 0;
> + *rev = PCI_ANY_ID;
> + if (!compat || strncasecmp(compat, "pci", 3) != 0)
> + goto failed;

No need to "goto failed" or "goto done".  Those labels don't do any
cleanup, so you can simply return here directly.

> + compat += 3;
> +
> + if (strncasecmp(compat, "class,", 6) == 0) {
> + /* pciclass,CCSSPP */
> + compat += 6;
> + if ((strlen(compat) < 4)
> + || kstrtouint(compat, 16, &id->class))
> + goto failed;
> + if (id->class < 0x10000) {
> + id->class <<= 8;
> + id->class_mask = 0xFFFF00;
> + } else {
> + id->class_mask = PCI_ANY_ID;
> + }
> + id->vendor = PCI_ANY_ID;
> + id->device = PCI_ANY_ID;
> + id->subvendor = PCI_ANY_ID;
> + id->subdevice = PCI_ANY_ID;
> + goto done;
> + }
> +
> + if (strncasecmp(compat, "ex", 2) == 0) {
> + /* pciex... */
> + *req_pcie = 1;
> + compat += 2;
> + }
> + if (kstrtou16(compat, 16, &res.u16))
> + goto failed;
> + id->vendor = res.u16;
> + compat = strchr(compat, ',');
> + if (!compat)
> + goto failed;
> + compat++;
> + if (kstrtou16(compat, 16, &res.u16))
> + goto failed;
> + id->device = res.u16;
> + compat = strchr(compat, '.');
> + if (compat == NULL) {
> + /* pciVVVV,DDDD */
> + id->subvendor = PCI_ANY_ID;
> + id->subdevice = PCI_ANY_ID;
> + goto done;
> + }
> +
> + compat++;
> + if (strlen(compat) == 2) {
> + /* pciVVVV,DDDD.RR */
> + if (kstrtou8(compat, 16, &res.u8))
> + goto failed;
> + *rev = res.u8;
> + id->subvendor = PCI_ANY_ID;
> + id->subdevice = PCI_ANY_ID;
> + goto done;
> + }
> +
> + if (kstrtou16(compat, 16, &res.u16))
> + goto failed;
> + id->subvendor = res.u16;
> + compat = strchr(compat, '.');
> + if (!compat)
> + goto failed;
> + compat++;
> + if (kstrtou16(compat, 16, &res.u16))
> + goto failed;
> + id->subdevice = res.u16;
> + compat = strchr(compat, '.');
> + if (compat == NULL)
> + /* pciVVVV,DDDD.SSSS.ssss */
> + goto done;
> +
> + compat++;
> + if (strlen(compat) == 2) {
> + /* pciVVVV,DDDD.SSSS.ssss.RR */
> + if (kstrtou8(compat, 16, &res.u8))
> + goto failed;
> + *rev = res.u8;
> + goto done;
> + }
> +
> + failed:
> + return -EINVAL;
> + done:
> + return 0;
> +}
> +
> +/**
> + * of_pci_compat_match_device() - Tell whether a PCI device structure
> matches
> + * a given OF compatibility string
> + * @compat: single OF compatibility string to match, could be NULL
> + * @dev the PCI device structure to match against
> + *
> + * Returns whether they match.
> + */
> +bool of_pci_compat_match_device(const char *compat, const struct pci_dev
> *dev)
> +{
> + __u32 rev = PCI_ANY_ID;
> + __u32 req_pcie = 0;
> + struct pci_device_id id = {0};
> +
> + if (of_pci_compat_to_device_id(compat, &id, &rev, &req_pcie))
> + return false;
> + return pci_match_one_device(&id, dev) &&
> + (rev == PCI_ANY_ID || rev == dev->revision) &&
> + req_pcie ? dev->pcie_cap : true;
> +}
> +
> +/**
> + * of_pci_node_match_device() - Tell whether an OF device tree node
> + * matches the given pci device
> + * @node: single OF device tree node to match, could be NULL
> + * @dev: the PCI device structure to match against, could be NULL
> + *
> + * Returns whether they match.
> + */
> +bool of_pci_node_match_device(const struct device_node *node,
> + const struct pci_dev *dev)
> +{
> + struct property *prop;
> + const char *cp;
> +
> + if (!node || !dev)
> + return false;
> + prop = of_find_property(node, "compatible", NULL);
> + for (cp = of_prop_next_string(prop, NULL); cp;
> + cp = of_prop_next_string(prop, cp)) {
> + if (of_pci_compat_match_device(cp, dev))
> + return true;
> + }
> + return false;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_node_match_device);
> +
> +/**
> + * of_pci_compat_match_one_id() - Tell whether a PCI device id structure

"ID" in English text since "id" is not really a word (well, I guess it
*is*, but not in the sense used here).

> matches
> + * a given OF compatibility string, note that there is no revision nor PCIe
> + * capability info in PCI device id structures
> + *
> + * @compat: single OF compatibility string to match, could be NULL
> + * @id the PCI device id structure to match against, could be NULL
> + *
> + * Returns the matching pci_device_id structure pointed by id
> + * or %NULL if there is no match.
> + */
> +const struct pci_device_id *
> +of_pci_compat_match_one_id(const char *compat, const struct pci_device_id
> *id)
> +{
> + __u32 rev = PCI_ANY_ID;
> + __u32 req_pcie = 0;
> + struct pci_device_id pr = {0};
> +
> + if (!compat || !id ||
> + of_pci_compat_to_device_id(compat, &pr, &rev, &req_pcie))
> + return NULL;
> + return pci_match_one_id(id, &pr);
> +}
> +
> +/**
> + * of_pci_compat_match_id_table() - Tell whether a given OF compatibility
> string
> + * matches a given pci_id table
> + *
> + * @compat: single OF compatibility string to match, could be NULL
> + * @table the PCI device id table to match against, could be NULL
> + *
> + * Returns the matching pci_device_id structure or %NULL if there is no
> match.
> + */
> +const struct pci_device_id *
> +of_pci_compat_match_id_table(const char *compat, const struct pci_device_id
> *table)
> +{
> + if (compat && table) {
> + while (table->vendor || table->subvendor || table->class_mask) {
> + if (of_pci_compat_match_one_id(compat, table))
> + return table;
> + table++;
> + }
> + }
> + return NULL;
> +}
> +
> +/**
> + * of_pci_node_match_id_table() - Tell whether an OF device tree node
> + * matches the given pci_id table
> + * @node: single OF device tree node to match, could be NULL
> + * @table: the PCI device id table to match against, could be NULL
> + *
> + * Returns the matching pci_device_id structure
> + * or %NULL if there is no match.
> + */
> +const struct pci_device_id *
> +of_pci_node_match_id_table(const struct device_node *node,
> + const struct pci_device_id *table)
> +{
> + struct property *prop;
> + const char *cp;
> + const struct pci_device_id *id;
> +
> + if (!node || !table)
> + return NULL;
> + prop = of_find_property(node, "compatible", NULL);
> + for (cp = of_prop_next_string(prop, NULL); cp;
> + cp = of_prop_next_string(prop, cp)) {
> + id = of_pci_compat_match_id_table(cp, table);
> + if (id)
> + return id;
> + }
> + return NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_node_match_id_table);
> +
> +/**
> + * of_pci_compat_match_driver - See if a given OF compatibility string
> matches
> + * a driver's list of IDs
> + * @compat: single OF compatibility string to match, could be NULL
> + * @drv: the PCI driver to match against, could be NULL
> + *
> + * Used by a driver to check whether an OF compatibility string matches one
> of
> + * (dynamically) supported devices, which may have been augmented
> + * via the sysfs "new_id" file. Returns the matching pci_device_id
> + * structure or %NULL if there is no match.
> + */
> +const struct pci_device_id *
> +of_pci_compat_match_driver(const char *compat, struct pci_driver *drv)
> +{
> + struct pci_dynid *dynid;
> + const struct pci_device_id *found_id = NULL, *ids;
> +
> + if (!compat || !drv)
> + return NULL;
> + /* Look at the dynamic ids first, before the static ones */
> + spin_lock(&drv->dynids.lock);
> + list_for_each_entry(dynid, &drv->dynids.list, node) {
> + if (of_pci_compat_match_one_id(compat, &dynid->id)) {
> + found_id = &dynid->id;
> + break;
> + }
> + }
> + spin_unlock(&drv->dynids.lock);
> +
> + if (found_id)
> + return found_id;
> +
> + for (ids = drv->id_table; (found_id = of_pci_compat_match_one_id(compat,
> ids));
> + ids = found_id + 1) {
> + /* exclude ids in id_table with override_only */
> + if (!found_id->override_only)
> + return found_id;
> + }
> +
> + return NULL;
> +}
> +
> +/**
> + * of_pci_node_match_driver() - Tell whether an OF device tree node
> + * matches the given pci driver
> + * @node: single OF device tree node to match, could be NULL
> + * @drv: the PCI driver structure to match against, could be NULL
> + *
> + * Returns the matching pci_device_id structure
> + * or %NULL if there is no match.
> + */
> +const struct pci_device_id *
> +of_pci_node_match_driver(const struct device_node *node,
> + struct pci_driver *drv)
> +{
> + struct property *prop;
> + const char *cp;
> + const struct pci_device_id *id;
> +
> + if (!node || !drv)
> + return NULL;
> + prop = of_find_property(node, "compatible", NULL);
> + for (cp = of_prop_next_string(prop, NULL); cp;
> + cp = of_prop_next_string(prop, cp)) {
> + id = of_pci_compat_match_driver(cp, drv);
> + if (id)
> + return id;
> + }
> + return NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_node_match_driver);
> +
> /**
> * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
> * host bridge resources from DT
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a2ceeacc33eb..aa212d12353f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -24,11 +24,6 @@
> #include "pci.h"
> #include "pcie/portdrv.h"
> -struct pci_dynid {
> - struct list_head node;
> - struct pci_device_id id;
> -};
> -
> /**
> * pci_add_dynid - add a new PCI device ID to this driver and re-probe
> devices
> * @drv: target pci driver
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b5550043..e30652021a63 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -204,6 +204,29 @@ pci_match_one_device(const struct pci_device_id *id,
> const struct pci_dev *dev)
> return NULL;
> }
> +/**
> + * pci_match_one_id - Tell if a PCI device id structure matches another
> + * PCI device id structure
> + * @id: single PCI device id structure to match, usually in a list or array
> + * @pr: the probing PCI device id structure to match against, usually
> converted from
> + * other format
> + *
> + * Returns the matching pci_device_id structure pointed by id
> + * or %NULL if there is no match.
> + */
> +static inline const struct pci_device_id *
> +pci_match_one_id(const struct pci_device_id *id, const struct pci_device_id
> *pr)
> +{
> + if ((id->vendor == pr->vendor) &&
> + (id->device == pr->device) &&
> + (id->subvendor == pr->subvendor) &&
> + (id->subdevice == pr->subdevice) &&
> + (id->class == pr->class) &&
> + (id->class_mask == pr->class_mask))
> + return id;
> + return NULL;
> +}
> +
> /* PCI slot sysfs helper code */
> #define to_pci_slot(s) container_of(s, struct pci_slot, kobj)
> @@ -638,6 +661,15 @@ void pci_release_bus_of_node(struct pci_bus *bus);
> int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge
> *bridge);
> +int of_pci_compat_to_device_id(const char *compat, struct pci_device_id
> *id,
> + __u32 *rev, __u32 *req_pcie);
> +bool of_pci_compat_match_device(const char *compat, const struct pci_dev
> *dev);
> +const struct pci_device_id *
> +of_pci_compat_match_one_id(const char *compat, const struct pci_device_id
> *id);
> +const struct pci_device_id *
> +of_pci_compat_match_id_table(const char *compat, const struct pci_device_id
> *table);
> +const struct pci_device_id *
> +of_pci_compat_match_driver(const char *compat, struct pci_driver *drv);
> #else
> static inline int
> of_pci_parse_bus_range(struct device_node *node, struct resource *res)
> @@ -679,6 +711,30 @@ static inline int devm_of_pci_bridge_init(struct device
> *dev, struct pci_host_br
> return 0;
> }
> +static inline int of_pci_compat_to_device_id(const char *compat, struct
> pci_device_id *id,
> + __u32 *rev, __u32 *req_pcie)
> +{
> + return -EINVAL;
> +}
> +static inline bool of_pci_compat_match_device(const char *compat, const
> struct pci_dev *dev)
> +{
> + return false;
> +}
> +static inline const struct pci_device_id *
> +of_pci_compat_match_one_id(const char *compat, const struct pci_device_id
> *id)
> +{
> + return NULL;
> +}
> +static inline const struct pci_device_id *
> +of_pci_compat_match_id_table(const char *compat, const struct pci_device_id
> *table)
> +{
> + return NULL;
> +}
> +static inline const struct pci_device_id *
> +of_pci_compat_match_driver(const char *compat, struct pci_driver *drv)
> +{
> + return NULL;
> +}
> #endif /* CONFIG_OF */
> #ifdef CONFIG_PCIEAER
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 29658c0ee71f..eef1eaafc03d 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -13,6 +13,14 @@ struct device_node *of_pci_find_child_device(struct
> device_node *parent,
> unsigned int devfn);
> int of_pci_get_devfn(struct device_node *np);
> void of_pci_check_probe_only(void);
> +bool of_pci_node_match_device(const struct device_node *node,
> + const struct pci_dev *dev);
> +const struct pci_device_id *
> +of_pci_node_match_id_table(const struct device_node *node,
> + const struct pci_device_id *table);
> +const struct pci_device_id *
> +of_pci_node_match_driver(const struct device_node *node,
> + struct pci_driver *drv);
> #else
> static inline struct device_node *of_pci_find_child_device(struct
> device_node *parent,
> unsigned int devfn)
> @@ -26,6 +34,23 @@ static inline int of_pci_get_devfn(struct device_node
> *np)
> }
> static inline void of_pci_check_probe_only(void) { }
> +static inline bool of_pci_node_match_device(const struct device_node *node,
> + const struct pci_dev *dev)
> +{
> + return false;
> +}
> +static inline const struct pci_device_id *
> +of_pci_node_match_id_table(const struct device_node *node,
> + const struct pci_device_id *table)
> +{
> + return NULL;
> +}
> +static inline const struct pci_device_id *
> +of_pci_node_match_driver(const struct device_node *node,
> + struct pci_driver *drv)
> +{
> + return NULL;
> +}
> #endif
> #if IS_ENABLED(CONFIG_OF_IRQ)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index adffd65e84b4..04c908d84b90 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1513,6 +1513,12 @@ void pci_unregister_driver(struct pci_driver *dev);
> builtin_driver(__pci_driver, pci_register_driver)
> struct pci_driver *pci_dev_driver(const struct pci_dev *dev);
> +
> +struct pci_dynid {
> + struct list_head node;
> + struct pci_device_id id;
> +};
> +
> int pci_add_dynid(struct pci_driver *drv,
> unsigned int vendor, unsigned int device,
> unsigned int subvendor, unsigned int subdevice,
> 
> -- 
> 2.39.0
> 
> 
