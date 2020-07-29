Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783CB23255A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 21:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2TYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 15:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2TYU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 15:24:20 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F29F62075D;
        Wed, 29 Jul 2020 19:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596050659;
        bh=S1E6H1oHWjFBLpWWWbW3nTMIr3sQ4srC4x2ffHleLB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DxnV9e4Uc5N35ib1XYpUch1HA1F0T3nFdfYJZ01pLqQL45afKNUXtYZfQqJddHt9/
         sRcit48nSKnoXHsBo/gPKSzGp9PtBfIvk8MFn6YGB07XfSR78iDzJVv7gJAZgrFNT1
         MrwPqmttDXnZnNCMJPSGuj+HsFpJO1tSJLkmhZcQ=
Date:   Wed, 29 Jul 2020 14:24:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix kerneldoc of pci_vc_do_save_buffer()
Message-ID: <20200729192416.GA1952120@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729062620.4168-1-krzk@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 29, 2020 at 08:26:20AM +0200, Krzysztof Kozlowski wrote:
> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

This looks great, but would you mind doing all the ones in drivers/pci
at the same time?  When I tested this, I also found the following, and
I don't think it's worth doing them one at a time:

  $ make W=1 drivers/pci/
  drivers/pci/hotplug/acpi_pcihp.c:69: warning: Function parameter or member 'pdev' not described in 'acpi_get_hp_hw_control_from_firmware'
  drivers/pci/hotplug/acpi_pcihp.c:69: warning: Excess function parameter 'dev' description in 'acpi_get_hp_hw_control_from_firmware'
  drivers/pci/hotplug/acpi_pcihp.c:199: warning: Function parameter or member 'handle' not described in 'acpi_pci_detect_ejectable'
  drivers/pci/endpoint/functions/pci-epf-test.c:189: warning: Function parameter or member 'epf_test' not described in 'pci_epf_test_clean_dma_chan'
  drivers/pci/endpoint/functions/pci-epf-test.c:189: warning: Excess function parameter 'epf' description in 'pci_epf_test_clean_dma_chan'
  drivers/pci/endpoint/pci-ep-cfs.c:17: warning: Function parameter or member 'functions_idr' not described in 'DEFINE_IDR'
  drivers/pci/endpoint/pci-epc-core.c:18: warning: cannot understand function prototype: 'struct class *pci_epc_class; '
  drivers/pci/endpoint/pci-epf-core.c:18: warning: Function parameter or member 'pci_epf_mutex' not described in 'DEFINE_MUTEX'
  drivers/pci/endpoint/pci-epf-core.c:80: warning: Function parameter or member 'epf' not described in 'pci_epf_free_space'
  drivers/pci/endpoint/pci-epf-core.c:107: warning: Function parameter or member 'epf' not described in 'pci_epf_alloc_space'
  drivers/pci/endpoint/pci-epc-mem.c:16: warning: Incorrect use of kernel-doc format:  * pci_epc_mem_get_order() - determine the allocation order of a memory size
  drivers/pci/endpoint/pci-epc-mem.c:24: warning: Function parameter or member 'mem' not described in 'pci_epc_mem_get_order'
  drivers/pci/endpoint/pci-epc-mem.c:24: warning: Function parameter or member 'size' not described in 'pci_epc_mem_get_order'
  drivers/pci/setup-bus.c:62: warning: Function parameter or member 'min_align' not described in 'add_to_list'
  drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'
  drivers/pci/of.c:262: warning: Function parameter or member 'ib_resources' not described in 'devm_of_pci_get_host_bridge_resources'
  drivers/pci/ats.c:196: warning: Function parameter or member 'pdev' not described in 'pci_enable_pri'
  drivers/pci/ats.c:196: warning: Function parameter or member 'reqs' not described in 'pci_enable_pri'
  drivers/pci/pci-pf-stub.c:20: warning: cannot understand function prototype: 'const struct pci_device_id pci_pf_stub_whitelist[] = '

> ---
> 
> Changes since v1:
> 1. Fix subject
> ---
>  drivers/pci/vc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> index 5486f8768c86..5fc59ac31145 100644
> --- a/drivers/pci/vc.c
> +++ b/drivers/pci/vc.c
> @@ -172,7 +172,6 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
>   * @dev: device
>   * @pos: starting position of VC capability (VC/VC9/MFVC)
>   * @save_state: buffer for save/restore
> - * @name: for error message
>   * @save: if provided a buffer, this indicates what to do with it
>   *
>   * Walking Virtual Channel config space to size, save, or restore it
> -- 
> 2.17.1
> 
