Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E462178B99B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjH1Uge (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 16:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjH1UgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 16:36:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B6102;
        Mon, 28 Aug 2023 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=f8ZX2ie61VwGl9M7CDZwuQMiBBUqXTpHUkef9SiXb2k=; b=ibAXVOKh/ScAc2wcxk/fjyI7rP
        b7lkK5iHyq2nQUgxLJKIqmVm9MEYk3H8XEnkEbuwOcfyJlI/q85QN3+l4xvy+nDOEVP9uQA8oIiDy
        c8R/zINglidNiGHLJ/cG902xDfyObyy7jBUOTLcJEUviW0Adhn0SpE1clcPtM8WEcB9zEhBAAkFk4
        TE68jYMSKbeelm/i9Clc+h7oKz5yyP86CBO6ZtEKCbW9wQ0+4at2aqgjRKJNcc2U8nLUCrZDOBRxV
        ER03/yNWR0d5OdPYdYrtDJJQLRDzTA7L+HTyp2qkgZ428DG0UzfyhuvpRLW4//sr2zeKsS8xIK8Kw
        KTs3iR9A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qaixs-00AF74-10;
        Mon, 28 Aug 2023 20:36:00 +0000
Message-ID: <ad664c17-9bd4-08ed-6a23-54de4a94e0a3@infradead.org>
Date:   Mon, 28 Aug 2023 13:35:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 28 (drivers/platform/x86/mlx-platform.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        PCI <linux-pci@vger.kernel.org>
References: <20230828150220.31624576@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230828150220.31624576@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/27/23 22:02, Stephen Rothwell wrote:
> Hi all,
> 
> Please do *not* include material destined for v6.7 in your linux-next
> included branches until *after* v6.6-rc1 has been released.  Also,
> do *not* rebase you linu-next included branches onto v6.5.
> 
> Changes since 20230825:
> 

on i386:
CONFIG_ACPI=y
CONFIG_ISA=y
# CONFIG_PCI is not set

../drivers/platform/x86/mlx-platform.c: In function 'mlxplat_pci_fpga_device_init':
../drivers/platform/x86/mlx-platform.c:6204:15: error: implicit declaration of function 'pci_request_region'; did you mean 'pci_request_regions'? [-Werror=implicit-function-declaration]
 6204 |         err = pci_request_region(pci_dev, 0, res_name);
      |               ^~~~~~~~~~~~~~~~~~
      |               pci_request_regions

Should MLX_PLATFORM depend on PCI?

or do we need a stub for pci_request_region()?

-- 
~Randy
