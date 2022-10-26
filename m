Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C0C60DA91
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 07:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiJZF2t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 01:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiJZF2o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 01:28:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD14C8FD4B
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 22:28:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29Q5SV1P103923;
        Wed, 26 Oct 2022 00:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666762111;
        bh=4V2S4hYtToUHWeXFP1st38WS3zPrwlXZPnZQ6+5giX8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AA6WFjQjQqqjlM8tlhC0+3KjeqkZc1zSIXc0PhLLmVcwJx4enPTSYgRSu/hoX5CZm
         InHkK8N2d2LGL0reB+QqRMzDyneJO9Z3A8xsXVgb62zPkBO1kmxRihj4lJYj8Pv1wF
         +DdzgYsi7AmxydsvXlpW/aPdghtcKKLeL8Dr6S5o=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29Q5SVBm004916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Oct 2022 00:28:31 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 26
 Oct 2022 00:28:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 26 Oct 2022 00:28:26 -0500
Received: from [10.250.234.133] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29Q5SNm4012279;
        Wed, 26 Oct 2022 00:28:24 -0500
Message-ID: <1b995d4a-1201-70f2-72f0-b5a8ea5e8451@ti.com>
Date:   Wed, 26 Oct 2022 10:58:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 3/3] PCI: j721e: Add warnings on num-lanes
 misconfiguration
Content-Language: en-US
To:     Matt Ranostay <mranostay@ti.com>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20221026015850.591044-1-mranostay@ti.com>
 <20221026015850.591044-4-mranostay@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221026015850.591044-4-mranostay@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 26/10/22 7:28 am, Matt Ranostay wrote:
> Added dev_warn messages to alert of devicetree misconfigurations
> for incorrect num-lanes setting, or the lack of one being defined.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

[...]

Regards
Vignesh


