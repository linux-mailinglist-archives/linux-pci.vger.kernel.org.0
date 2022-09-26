Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B6D5E9827
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 05:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiIZDG4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Sep 2022 23:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiIZDGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Sep 2022 23:06:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4872A708;
        Sun, 25 Sep 2022 20:06:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28Q36dGj043721;
        Sun, 25 Sep 2022 22:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664161599;
        bh=h3OvXzV0yd/AeovBKdhGD6ntYjKNXz8xxfV6ZK4mVOY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ESpHA26jJrhXeRgroEBY3QKLX2ZGY6XfWAFQTtUJ9hSOefnnQ6FU9k7YOor1+Hv88
         lmHckuAihrXoWJ5Rc+eWBbACDYRKOcP6PrEkcsp+LHN42VAVy9HTJL4wCdt4l96i9K
         oXZD18mPPeT23ObrstVvytDbLYfTFV51e6Yq33iM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28Q36dux078452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Sep 2022 22:06:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sun, 25
 Sep 2022 22:06:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sun, 25 Sep 2022 22:06:38 -0500
Received: from ubuntu (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with SMTP id 28Q36WOV050609;
        Sun, 25 Sep 2022 22:06:33 -0500
Date:   Sun, 25 Sep 2022 20:06:31 -0700
From:   Matt Ranostay <mranostay@ti.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <vigneshr@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] dt-bindings: PCI: ti,j721e-pci-*: resolve
 unexpected property warnings
Message-ID: <YzEXN88AAa7tZvyE@ubuntu>
References: <20220924223517.123343-1-mranostay@ti.com>
 <b820b84b-609f-6b1a-fb9f-fde05ce88f7f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b820b84b-609f-6b1a-fb9f-fde05ce88f7f@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 25, 2022 at 11:21:02AM +0200, Krzysztof Kozlowski wrote:
> On 25/09/2022 00:35, Matt Ranostay wrote:
> > Resolve unexpected property warnings related to interrupts in both J721E PCI EP and host
> > yaml files.
> > 
> 
> Thanks for cc-ing. On what tree do you base your patch? Looks like
> something old. If so, you need to rebase to some recent kernel.
>

It was on linux-next from Sep 23rd. So would seem odd if the rebasing seems
from an older tree. 

- Matt

> Best regards,
> Krzysztof
> 
