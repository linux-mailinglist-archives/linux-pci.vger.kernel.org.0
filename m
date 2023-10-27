Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5211D7D92B9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJ0IyM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 04:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345922AbjJ0IyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 04:54:00 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3275E1FDD;
        Fri, 27 Oct 2023 01:44:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39R8i4I7124816;
        Fri, 27 Oct 2023 03:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698396244;
        bh=bbldL+suysW8lOgKnrNgnFl9jcKCMUDGWd1WDtVyKik=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=wO472lvQy+0a+Lqu4K7L78x4EYk/AJZn36z4NffvYMRNE8Obss07EcrINk06ila3y
         KLrrJ4H9BrCZ8RAGRJmiAl2m9/cjEdHlkp5xdfa3iv40vK4E488Tyt3GuhJHSjA2u6
         ER6nzb5PSo3H4xwaOCgPHDDLBhz4xfUaJ6ehk8uA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39R8i4wZ012524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 03:44:04 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 03:44:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 03:44:04 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39R8hx6o003057;
        Fri, 27 Oct 2023 03:44:00 -0500
Message-ID: <23209a7a-0f8a-4670-9132-e99a42df06f9@ti.com>
Date:   Fri, 27 Oct 2023 14:13:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20231023212628.GA1627567@bhelgaas>
 <c7851172-f474-42f3-9730-1f323f9e6c73@ti.com>
 <3szgydgz7ege5h75mwdket5lniwy4oe52dq2uqehf74il5hc5j@oaqcbmfuf6de>
 <6e40c4ee-e549-4b41-8a12-65b474b8ef24@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <6e40c4ee-e549-4b41-8a12-65b474b8ef24@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn, Serge,

On 25/10/23 16:28, Siddharth Vadapalli wrote:
> Serge,
> 
> I will post it as a separate cleanup patch in that case and this v3 patch can be
> merged independently as you suggested.

I have posted the patch as an RFC patch at:
https://lore.kernel.org/r/20231027084159.4166188-1-s-vadapalli@ti.com/

-- 
Regards,
Siddharth.
