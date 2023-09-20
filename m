Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795077A742A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjITHcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Sep 2023 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjITHcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 03:32:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CC8C9;
        Wed, 20 Sep 2023 00:32:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B513C433C7;
        Wed, 20 Sep 2023 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195133;
        bh=u4vRJ0fWq09I70IbE8AlVp8IxBCPKi9zruFPuhoW71I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fzz+vHPmATbFrOQfMThFtGdHivljc/gBNrI4IvIM/humx6Cahew02s28qb9rd8/Pa
         Qicu9H6EThaCTLLlO6LSEuBlakUaj1+KPJ1kQX9OIoT2RDTsNxSLZG3cSFaJo5U2Gc
         /04IX4AI/oRwIKx+yzRQ+RAzMELckv9BAlq8u9jI6/7zqugirHxv3RF6f98LxkI8I8
         Bc1bllvrlJzmC8+fNFCnukrUhDsk5AwtVSaEDO6CKM6h23Xr3PZ4RnXBSkiNUctfQB
         NcS6QL/Q6Ax7OsDqB0n2DJgKPu2DZG2mN35VPJXBL0UVAyz8cLEMoKzWhBnz9dMzD1
         oCXjIw9CFe8ZQ==
Date:   Wed, 20 Sep 2023 10:32:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] PCI/treewide: PCIe capability access cleanups
Message-ID: <20230920073210.GI4494@unreal>
References: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919125648.1920-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 03:56:40PM +0300, Ilpo Järvinen wrote:
> Instead of custom code to extract the PCIe capabilities, make the code
> more obvious using FIELD_GET/PREP().
> 
> Also cleanup some duplicated defines in e1000e.
> 
> This is just a step into the right direction, there's plenty of places
> still to cleanup which will have to wait for another patch series.
> 
> v3:
> - Remove applied patches (scsi)
> - Use pci_pcie_cap() and tweak local variable (e1000e)
> - Use the correct prefix for RDMA/hfi1
> 
> v2:
> - Remove extract_width() and use FIELD_GET() directly (IB/hfi1)
> - Convert other fields beside Link Width ones
> - Remove useless u8 casts (scsi: esas2r)
> - e1000e:
>         - Remove defines that duplicate pci_regs.h ones
>         - Convert to pcie_capability_read_word()
> 
> 
> Ilpo Järvinen (8):
>   RDMA/hfi1: Use FIELD_GET() to extract Link Width

Applied this patch to RDMA tree.

Thanks
