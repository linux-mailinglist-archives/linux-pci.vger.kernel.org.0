Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0A64E0BC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLOS1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLOS1I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 13:27:08 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3349B5B;
        Thu, 15 Dec 2022 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=jqMEDeWBrjVZzXSeVS/jldK/d6kBDhQQz9ZteGOroFI=; b=krHv2dKaq7UsdCKaakpvQE8GzR
        7nqDl2+YWnjcKiNTkSxM0eNtkVREAQN6rtZVejCbT1uggjHWW8w/CmUJgaPMHzfo4sNosLxcXdrjN
        tb6sWy7OE5zMOqvMlMRiEstYfNcFGV+9GJ9X3cSJBt6Qs+TMbrTUHdIA6EqEWIoUwZEb+fqQUSqa0
        AqKhGFyPZ9vMrpr/SZWpJAS/tvSkYVqsLJQHP0CzQ00cvRvT1yLTE7vEpjpja8mdi83UDzJpOPYjX
        cjmjtZBrBkFv1OpGEljISLnWggy1RSY+TRuKjZnkcrC6Rwm5Hn01lrn74cIrpSeoi7OkUsoo7LUOP
        a+dk/bYg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1p5swU-0094Mo-I5; Thu, 15 Dec 2022 11:26:51 -0700
Message-ID: <f4f1f1b1-018f-dbee-eeba-ff84dfca899d@deltatee.com>
Date:   Thu, 15 Dec 2022 11:26:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221215182140.129559-1-helgaas@kernel.org>
 <20221215182140.129559-2-helgaas@kernel.org>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20221215182140.129559-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: helgaas@kernel.org, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 1/2] PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-12-15 11:21, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The "ret" variable in switchtec_dma_mrpc_isr() is superfluous.  Remove it
> and just return the value.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
