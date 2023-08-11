Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053917794F1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjHKQoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjHKQoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 12:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684E30CF;
        Fri, 11 Aug 2023 09:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2887C637CA;
        Fri, 11 Aug 2023 16:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CEAC433C8;
        Fri, 11 Aug 2023 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772246;
        bh=nn4DsX3NjYDMmCCWyYxoD2bZ/OQoZyEjanF5PEtiF2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OOinyVzeNbVD8Kc5kgzzBvWAPHPHaWHv17is5miVFC4Q2sdzbdIYE2emht+9kPmxH
         iNeQ6iERZBL4Rd4rkAEmWxtwI46wQ4fcx6EIRhkPjbioBcQOO1rRR10arNMYs2a5LO
         KRifpJXSIl0B/wof1VnFaGALKOdR0YhKhDi7aR5V8L9ITPBqcU2C0cX2A3MMhflhn3
         5PInPT0hXaHczWepuWKexGPEbzWblv9rGcFZJSPSFcgsUq2lasGhlmue02RBffNP7X
         vMXT5L5CJDB+oaXNqfoSI9fzZ4uD8RcjuH1tMLXR3Dek6NGZp2Pp7kJbg1LQQii8e2
         2ksXOYJZHLu/A==
Date:   Fri, 11 Aug 2023 11:44:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        scott@spiteful.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: Remove unused function declarations
Message-ID: <20230811164404.GA75943@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811095933.28652-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 11, 2023 at 05:59:33PM +0800, Yue Haibing wrote:
> These declarations is never implemented since the beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Applied to pci/misc for v6.6, thank you!

> ---
>  drivers/pci/hotplug/acpiphp.h      | 1 -
>  drivers/pci/hotplug/cpci_hotplug.h | 2 --
>  drivers/pci/hotplug/ibmphp.h       | 2 --
>  include/linux/pci.h                | 1 -
>  4 files changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
> index 1f8ab4377ad8..5745be6018e1 100644
> --- a/drivers/pci/hotplug/acpiphp.h
> +++ b/drivers/pci/hotplug/acpiphp.h
> @@ -178,7 +178,6 @@ void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *slot);
>  int acpiphp_enable_slot(struct acpiphp_slot *slot);
>  int acpiphp_disable_slot(struct acpiphp_slot *slot);
>  u8 acpiphp_get_power_status(struct acpiphp_slot *slot);
> -u8 acpiphp_get_attention_status(struct acpiphp_slot *slot);
>  u8 acpiphp_get_latch_status(struct acpiphp_slot *slot);
>  u8 acpiphp_get_adapter_status(struct acpiphp_slot *slot);
>  
> diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
> index 3fdd1b9bd8c3..6d8970d8c3f2 100644
> --- a/drivers/pci/hotplug/cpci_hotplug.h
> +++ b/drivers/pci/hotplug/cpci_hotplug.h
> @@ -83,8 +83,6 @@ extern int cpci_debug;
>   * board/chassis drivers.
>   */
>  u8 cpci_get_attention_status(struct slot *slot);
> -u8 cpci_get_latch_status(struct slot *slot);
> -u8 cpci_get_adapter_status(struct slot *slot);
>  u16 cpci_get_hs_csr(struct slot *slot);
>  int cpci_set_attention_status(struct slot *slot, int status);
>  int cpci_check_and_clear_ins(struct slot *slot);
> diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
> index 0399c60d2ec1..41eafe511210 100644
> --- a/drivers/pci/hotplug/ibmphp.h
> +++ b/drivers/pci/hotplug/ibmphp.h
> @@ -264,8 +264,6 @@ extern struct list_head ibmphp_slot_head;
>  void ibmphp_free_ebda_hpc_queue(void);
>  int ibmphp_access_ebda(void);
>  struct slot *ibmphp_get_slot_from_physical_num(u8);
> -int ibmphp_get_total_hp_slots(void);
> -void ibmphp_free_ibm_slot(struct slot *);
>  void ibmphp_free_bus_info_queue(void);
>  void ibmphp_free_ebda_pci_rsrc_queue(void);
>  struct bus_info *ibmphp_find_same_bus_num(u32);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index eeb2e6f6130f..494470a38abf 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1403,7 +1403,6 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
>  void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
>  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
>  int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
> -void pdev_enable_device(struct pci_dev *);
>  int pci_enable_resources(struct pci_dev *, int mask);
>  void pci_assign_irq(struct pci_dev *dev);
>  struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res);
> -- 
> 2.34.1
> 
