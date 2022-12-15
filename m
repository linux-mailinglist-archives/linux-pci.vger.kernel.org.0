Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365664E102
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 19:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLOSgt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 13:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLOSg0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 13:36:26 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA4B1DA;
        Thu, 15 Dec 2022 10:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=GoloFkU/vNZ84bs6+Vb1Xe1eV0+apXeTjGeADCpv3pY=; b=GxscIznVUvPAXKk2KGcIAhO2nI
        68eTeB3VjlnXyrX7S7QQPUB3rrnhJv0el+BcKk/X8lyRAQUQGhmfkN9H2Wz89CZ6s8X1WZM0quwY6
        XEufSNdHNunIIGh69WrB2LSqTvKWUB9OxORis8otnUkzd6JpTOK/CBKUb0Vzj7cmjFS+OlOP/kL9g
        dElljPTBOqINk+CDzeJeJssLxjZc0IT4elU6wFnM7sF6qYL3bHC8XwTfw6aN58wGhFJHeuvlyNYso
        WD7UvpSD7WhS4cqc9KqDf2SJrAn+/h0FQ7Jj/RZPKSeueh8L8g/9MWb5rn8HnEpwCpD2x3RAgwRrV
        QhjuhfAg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1p5t3W-0094PT-Lm; Thu, 15 Dec 2022 11:34:08 -0700
Message-ID: <81a72082-94ec-4011-1e54-3b278317a44e@deltatee.com>
Date:   Thu, 15 Dec 2022 11:34:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221215182140.129559-1-helgaas@kernel.org>
 <20221215182140.129559-3-helgaas@kernel.org>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20221215182140.129559-3-helgaas@kernel.org>
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
Subject: Re: [PATCH 2/2] PCI: switchtec: Remove useless assignments in
 switchtec_dev_read()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-12-15 11:21, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Some switchtec_dev_read() error cases assign to "rc", then branch to "out".
> But the code at "out" never uses "rc".  Drop the useless assignments.  No
> functional change intended.

Ah, hmm, yes. I think if copy_to_user() fails, the function should
probably return -EFAULT. So perhaps an unlock and specific return as is
done in previous conditions in the same function?

Thanks,

Logan
