Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473C1232564
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG2T1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 15:27:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45903 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgG2T1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 15:27:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id di22so11066729edb.12;
        Wed, 29 Jul 2020 12:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqzkB1yMtwTwe0QIggl9r67QOv8/59iTGPFZ5uluyfk=;
        b=V6gXlCgw8OYT3T8WZTMOlwE4ElpCGj9XiQN1hXTjf6Nq62ZTZwsSolnaqYDcisqeUt
         V1dWoWA5WyB5UtF36mLijt16mygMPV7saHjzfRFJvdJ+0v51uPIL3QBAJH0SY4QK1Oa8
         brgpOA8VHlM3TTjk54V2NnRd2tUBTNTxO9pq77VhTw2RUQ9eI4swcd+KD+761R7dh/m4
         p18Amr7LeouXZu/4Gta1Doltpe9WhzhmPOqi+gZ1sAsGlbMazhgaNrYJcN3Bw5/3eCHj
         8+Mugk6sUFt0HBwVMiPYq7PRxKVLlezelSbcuyz29AwMjnzWDvdsvjtVZy9iGklsxiWa
         v84Q==
X-Gm-Message-State: AOAM533lr+juw8xmO2N6B9X7V0dGEaQWWpYIOw1OwnvG3oRSo8WnDwt5
        1Td3AraM5T908mShvz4aqUzYWJqgevQ=
X-Google-Smtp-Source: ABdhPJxObnVIyDyOgqaH4yWPwEYKAEvkNYKHKyCvuebyOPXp7LV+HEj+KEmaBw3MKXw6vmabtZS16g==
X-Received: by 2002:aa7:c697:: with SMTP id n23mr52240edq.50.1596050839891;
        Wed, 29 Jul 2020 12:27:19 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id x16sm2680404edr.52.2020.07.29.12.27.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 12:27:19 -0700 (PDT)
Date:   Wed, 29 Jul 2020 21:27:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix kerneldoc of pci_vc_do_save_buffer()
Message-ID: <20200729192717.GA7457@kozik-lap>
References: <20200729062620.4168-1-krzk@kernel.org>
 <20200729192416.GA1952120@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729192416.GA1952120@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 29, 2020 at 02:24:16PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 29, 2020 at 08:26:20AM +0200, Krzysztof Kozlowski wrote:
> > Fix W=1 compile warnings (invalid kerneldoc):
> > 
> >     drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> This looks great, but would you mind doing all the ones in drivers/pci
> at the same time?  When I tested this, I also found the following, and
> I don't think it's worth doing them one at a time:
> 
>   $ make W=1 drivers/pci/
>   drivers/pci/hotplug/acpi_pcihp.c:69: warning: Function parameter or member 'pdev' not described in 'acpi_get_hp_hw_control_from_firmware'
>   drivers/pci/hotplug/acpi_pcihp.c:69: warning: Excess function parameter 'dev' description in 'acpi_get_hp_hw_control_from_firmware'
>   drivers/pci/hotplug/acpi_pcihp.c:199: warning: Function parameter or member 'handle' not described in 'acpi_pci_detect_ejectable'
>   drivers/pci/endpoint/functions/pci-epf-test.c:189: warning: Function parameter or member 'epf_test' not described in 'pci_epf_test_clean_dma_chan'
>   drivers/pci/endpoint/functions/pci-epf-test.c:189: warning: Excess function parameter 'epf' description in 'pci_epf_test_clean_dma_chan'
>   drivers/pci/endpoint/pci-ep-cfs.c:17: warning: Function parameter or member 'functions_idr' not described in 'DEFINE_IDR'
>   drivers/pci/endpoint/pci-epc-core.c:18: warning: cannot understand function prototype: 'struct class *pci_epc_class; '
>   drivers/pci/endpoint/pci-epf-core.c:18: warning: Function parameter or member 'pci_epf_mutex' not described in 'DEFINE_MUTEX'
>   drivers/pci/endpoint/pci-epf-core.c:80: warning: Function parameter or member 'epf' not described in 'pci_epf_free_space'
>   drivers/pci/endpoint/pci-epf-core.c:107: warning: Function parameter or member 'epf' not described in 'pci_epf_alloc_space'
>   drivers/pci/endpoint/pci-epc-mem.c:16: warning: Incorrect use of kernel-doc format:  * pci_epc_mem_get_order() - determine the allocation order of a memory size
>   drivers/pci/endpoint/pci-epc-mem.c:24: warning: Function parameter or member 'mem' not described in 'pci_epc_mem_get_order'
>   drivers/pci/endpoint/pci-epc-mem.c:24: warning: Function parameter or member 'size' not described in 'pci_epc_mem_get_order'
>   drivers/pci/setup-bus.c:62: warning: Function parameter or member 'min_align' not described in 'add_to_list'
>   drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'
>   drivers/pci/of.c:262: warning: Function parameter or member 'ib_resources' not described in 'devm_of_pci_get_host_bridge_resources'
>   drivers/pci/ats.c:196: warning: Function parameter or member 'pdev' not described in 'pci_enable_pri'
>   drivers/pci/ats.c:196: warning: Function parameter or member 'reqs' not described in 'pci_enable_pri'
>   drivers/pci/pci-pf-stub.c:20: warning: cannot understand function prototype: 'const struct pci_device_id pci_pf_stub_whitelist[] = '

Sure, I can work on more of them. Somehow this one got enabled on my
build (usually it does not contain PCI) and I decided to fix it.

It's a compiler warning so still even one-at-a-time brings us closer to
clean builds.

Best regards,
Krzysztof

