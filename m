Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B479ACE0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjIKVjy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 11 Sep 2023 17:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243983AbjIKSex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 14:34:53 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD3198;
        Mon, 11 Sep 2023 11:34:49 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6bf106fb6a0so759115a34.0;
        Mon, 11 Sep 2023 11:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694457288; x=1695062088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ozIqsa4ll2dstGJiKnp+cx3giqAznmjtqmzWaRuC2Y=;
        b=u1NFRWSVNljmDDz5OI7n/VdponouHW25zCi0md/BIKPH6/W860SzEU5uqQBvtIhO6d
         crY8E9fUwGPh/PZ57LdtJx2QiSFKwKxSnx4HuGswRaBfllNt9kFW7jQNEIowR4MJgs/U
         BW+PAp44fbXCUHykF3ux7DVudE6LfJtd6PIYDG2FD+wjMOSEhmZcKSW5xZoWxIg/idck
         uXFyy0lm+XhGjgBpnl8UbiirHlXKK8+3wKvgzUWlmHk+BQ+dwqO4XBIy9pSJyCxsFJ30
         HQrHT7MOhMcvy1GBjUnNlARrBbo34UwvCLxBKUCA8ss8JWTrK1SCr3LoHdv81ZAtGf9d
         qV1A==
X-Gm-Message-State: AOJu0YxQS7RQgQEtMonnlG0rsAmht7bT0DznwS/OQyUfeaJeBuNhf7cs
        bzXa2hko1iCoCt+hwGyQJww3iu0DUDo4RqZhpLA=
X-Google-Smtp-Source: AGHT+IETfSXiDrOmPCMB2ku2g4cKUUFkv5dF7tlnnSknEk84cwUOYcvU7muL8DylEGougjYynYy0zJ0ORQlzuqz94hM=
X-Received: by 2002:a05:6808:23ca:b0:3aa:867:c7f0 with SMTP id
 bq10-20020a05680823ca00b003aa0867c7f0mr12781634oib.0.1694457288235; Mon, 11
 Sep 2023 11:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230906184354.45846-1-mario.limonciello@amd.com> <20230906184354.45846-3-mario.limonciello@amd.com>
In-Reply-To: <20230906184354.45846-3-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Sep 2023 20:34:37 +0200
Message-ID: <CAJZ5v0jgGOPcFMfRObAM1St1KLjZS0tEki4f32Rbr3ZXwFyFzA@mail.gmail.com>
Subject: Re: [PATCH v17 2/4] PCI: Add support for drivers to register optin or
 veto of D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 6, 2023 at 9:16 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> from modern machines (>=2015) are allowed to be put into D3.
>
> This policy change has worked for most machines, but the behavior
> is improved with `pcie_port_pm=off` on some others.
>
> Add support for drivers to register both 'optin' and 'veto' callbacks
> and a priority which can be used for deciding whether a device should
> use D3. When drivers register the callbacks, the list is sorted by
> priority.
>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c   | 143 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |   9 +++
>  2 files changed, 152 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..06ab73f58adf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> +#include <linux/list_sort.h>
>  #include <linux/log2.h>
>  #include <linux/logic_pio.h>
>  #include <linux/pm_wakeup.h>
> @@ -54,6 +55,8 @@ unsigned int pci_pm_d3hot_delay;
>  static void pci_pme_list_scan(struct work_struct *work);
>
>  static LIST_HEAD(pci_pme_list);
> +static LIST_HEAD(d3_possible_list);
> +static DEFINE_MUTEX(d3_possible_list_mutex);
>  static DEFINE_MUTEX(pci_pme_list_mutex);
>  static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
>
> @@ -161,6 +164,14 @@ static bool pcie_ats_disabled;
>  /* If set, the PCI config space of each device is printed during boot. */
>  bool pci_early_dump;
>
> +/* Preferences set by a driver for D3 optin/veto */
> +enum driver_d3_pref {
> +       D3_PREF_UNSET,  /* Not configured by driver */
> +       D3_PREF_NONE,   /* Driver does not care */
> +       D3_PREF_OPTIN,  /* Driver prefers D3 */
> +       D3_PREF_VETO,   /* Driver vetoes D3 */
> +};
> +
>  bool pci_ats_disabled(void)
>  {
>         return pcie_ats_disabled;
> @@ -3031,6 +3042,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                 if (pci_bridge_d3_force)
>                         return true;
>
> +               /* check for any driver optin of D3 for the bridge */
> +               if (bridge->driver_d3 == D3_PREF_OPTIN)
> +                       return true;
> +
>                 /* Even the oldest 2010 Thunderbolt controller supports D3. */
>                 if (bridge->is_thunderbolt)
>                         return true;
> @@ -3050,6 +3065,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                 if (dmi_check_system(bridge_d3_blacklist))
>                         return false;
>
> +               /* check for any driver veto for D3 for the bridge */
> +               if (bridge->driver_d3 == D3_PREF_VETO)
> +                       return false;
> +
>                 /*
>                  * It should be safe to put PCIe ports from 2015 or newer
>                  * to D3.
> @@ -3168,6 +3187,130 @@ void pci_d3cold_disable(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>
> +static struct pci_dev *pci_get_upstream_port(struct pci_dev *pci_dev)
> +{
> +       struct pci_dev *bridge;
> +
> +       bridge = pci_upstream_bridge(pci_dev);
> +       if (!bridge)
> +               return NULL;
> +
> +       if (!pci_is_pcie(bridge))
> +               return NULL;
> +
> +       switch (pci_pcie_type(bridge)) {
> +       case PCI_EXP_TYPE_ROOT_PORT:
> +       case PCI_EXP_TYPE_UPSTREAM:
> +       case PCI_EXP_TYPE_DOWNSTREAM:
> +               return bridge;
> +       default:
> +               break;
> +       };
> +
> +       return NULL;
> +}
> +
> +static void pci_refresh_d3_possible(void)
> +{
> +       struct pci_d3_driver_ops *driver;
> +       struct pci_dev *pci_dev = NULL;
> +       struct pci_dev *bridge;
> +
> +       /* 1st pass: unset any preferences set a previous invocation */
> +       while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
> +               bridge = pci_get_upstream_port(pci_dev);
> +               if (!bridge)
> +                       continue;
> +
> +               if (bridge->driver_d3 != D3_PREF_UNSET)
> +                       bridge->driver_d3 = D3_PREF_UNSET;
> +       }
> +
> +       pci_dev = NULL;
> +
> +       /* 2nd pass: update the preference and refresh bridge_d3 */
> +       while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
> +               bridge = pci_get_upstream_port(pci_dev);
> +               if (!bridge)
> +                       continue;
> +
> +               /* don't make multiple passes on the same device */
> +               if (bridge->driver_d3 != D3_PREF_UNSET)
> +                       continue;
> +
> +               /* the list is pre-sorted by highest priority */
> +               mutex_lock(&d3_possible_list_mutex);
> +               list_for_each_entry(driver, &d3_possible_list, list_node) {
> +                       /* another higher priority driver already set preference */
> +                       if (bridge->driver_d3 != D3_PREF_UNSET)
> +                               break;
> +                       /* check for opt in to D3 */
> +                       if (driver->optin && driver->optin(bridge))
> +                               bridge->driver_d3 = D3_PREF_OPTIN;
> +                       /* check for opt out of D3 */
> +                       else if (driver->veto && driver->veto(bridge))
> +                               bridge->driver_d3 = D3_PREF_VETO;
> +               }
> +               mutex_unlock(&d3_possible_list_mutex);
> +
> +               /* no driver set a preference */
> +               if (bridge->driver_d3 == D3_PREF_UNSET)
> +                       bridge->driver_d3 = D3_PREF_NONE;
> +
> +               /* update bridge_d3 */
> +               pci_bridge_d3_update(pci_dev);
> +       }
> +}
> +
> +static int pci_d3_driver_cmp(void *priv, const struct list_head *_a,
> +                          const struct list_head *_b)
> +{
> +       struct pci_d3_driver_ops *a = container_of(_a, typeof(*a), list_node);
> +       struct pci_d3_driver_ops *b = container_of(_b, typeof(*b), list_node);
> +
> +       if (a->priority < b->priority)
> +               return -1;
> +       else if (a->priority > b->priority)
> +               return 1;
> +       return 0;
> +}
> +
> +/**
> + * pci_register_d3_possible_cb - Register a driver callback for checking d3 veto
> + * @arg: driver provided structure with function pointer and priority
> + *
> + * This function can be used by drivers to register a callback that can be
> + * used to veto a device going into D3.
> + * Returns 0 on success, error code on failure.
> + */
> +int pci_register_d3_possible_cb(struct pci_d3_driver_ops *arg)
> +{
> +       mutex_lock(&d3_possible_list_mutex);
> +       list_add(&arg->list_node, &d3_possible_list);
> +       list_sort(NULL, &d3_possible_list, pci_d3_driver_cmp);
> +       mutex_unlock(&d3_possible_list_mutex);
> +       pci_refresh_d3_possible();
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_register_d3_possible_cb);
> +
> +/**
> + * pci_unregister_d3_possible_cb - Unregister a driver callback for checking d3 veto
> + * @arg: driver provided structure with function pointer and priority
> + *
> + * This function can be used by drivers to unregister a callback that can be
> + * used to veto a device going into D3.
> + */
> +void pci_unregister_d3_possible_cb(struct pci_d3_driver_ops *arg)
> +{
> +       mutex_lock(&d3_possible_list_mutex);
> +       list_del(&arg->list_node);
> +       list_sort(NULL, &d3_possible_list, pci_d3_driver_cmp);
> +       mutex_unlock(&d3_possible_list_mutex);
> +       pci_refresh_d3_possible();
> +}
> +EXPORT_SYMBOL_GPL(pci_unregister_d3_possible_cb);
> +
>  /**
>   * pci_pm_init - Initialize PM functions of given PCI device
>   * @dev: PCI device to handle.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8c7c2c3c6c65..863399e78869 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -389,6 +389,7 @@ struct pci_dev {
>                                                    bit manually */
>         unsigned int    d3hot_delay;    /* D3hot->D0 transition time in ms */
>         unsigned int    d3cold_delay;   /* D3cold->D0 transition time in ms */
> +       unsigned int    driver_d3;      /* Driver D3 request preference */
>
>  #ifdef CONFIG_PCIEASPM
>         struct pcie_link_state  *link_state;    /* ASPM link state */
> @@ -1404,6 +1405,14 @@ void pci_d3cold_disable(struct pci_dev *dev);
>  bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
>  void pci_resume_bus(struct pci_bus *bus);
>  void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
> +struct pci_d3_driver_ops {
> +       struct list_head list_node;
> +       int priority;
> +       bool (*optin)(struct pci_dev *pdev);
> +       bool (*veto)(struct pci_dev *pdev);
> +};
> +int pci_register_d3_possible_cb(struct pci_d3_driver_ops *arg);
> +void pci_unregister_d3_possible_cb(struct pci_d3_driver_ops *arg);
>
>  /* For use by arch with custom probe code */
>  void set_pcie_port_type(struct pci_dev *pdev);
> --

I don't like this too much TBH.  It appears overly complicated to me
and it totally misses the wakeup vs non-wakeup point I've been talking
about recently.

IMV, the underlying issue all boils down to the platform firmware
inadequately describing the behavior of the system to the OS.
Specifically, had it provided a _S0W returning 0 for the Root Port(s)
in question, wakeup signaling would have worked (or else there would
have been a defect in the kernel code to be addressed).  Instead, it
decided to kind-of guide Windows in the "right" direction through PEP
constraints which doesn't have the same effect on Linux and honestly
I'm not even sure if it is a good idea to adjust Linux to that.

It looks to me like the issue could be addressed by a PCI device quirk
playing the role of a missing _S0W (but slightly more precise, because
it may distinguish suspend-to-idle from PM-runtime, which _S0W cannot
do).
