Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB953502C
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiEZNsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 May 2022 09:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiEZNsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 May 2022 09:48:41 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA627B1A;
        Thu, 26 May 2022 06:48:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D9671320095C;
        Thu, 26 May 2022 09:48:36 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Thu, 26 May 2022 09:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1653572916; x=1653659316; bh=NY
        IVhGFaH21Cr/Vp3OtFhX0ZaD6txFbd1zpyaA0rArY=; b=iQdmEFfx2FdO1MLAeW
        jQobK/4JiiJAst/v6oT8eeU6NcPfbhmh+D/kJBp+dwiREv/XbQij6Kc6mgaXJVKz
        cO8eIKfZu7uTz5ZLXjTqS/HH+0YF7siLGGKRwk4kJZhz0SZk4hYCdMIjyq3bEk8Q
        DLSfoQUHDNOnSDGX48GBPLrC3jR6Umi44txeZdOQOHLGpc/1T6Zny0fB/PJmrsHx
        0S7nGbfsZ72f8iNdocA2uuW9t/tKdLZEOOmPsfyEVlZUXo8KgG1xnkefsc/9jg05
        QEzWT85rDt2Td2nP0Xje3da6UffTGTtHqm6jj7xHE6Z6YdQa4XQ0dj80yFurkuti
        W5lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653572916; x=1653659316; bh=NYIVhGFaH21Cr/Vp3OtFhX0ZaD6t
        xFbd1zpyaA0rArY=; b=iYhQMtBJ0eLzsXh2lRIhOI/Izn/pVF68W14ULfHSKMt5
        4A9pHrqMYyc/TSm98fg+roHJbCKbMacZGPAhocAiMNT9tlOqORP3xY0hu9L6F609
        Hwp3xeZ0QavigR14J/fPR1hKXM6Jve1M5AgPiNMkCk2wBAJEYG8y0yTqSe0gXL+/
        bEBw/ZuSe+wlMbfYDWtQKPzLcAO02TD9K+ezWJZ6GIkoevE0qp/oq0imeX6fdY6S
        QfyLpLzy/IbV+ku+pD5WYM+dCLP9VUM1RZCk13zaVRQ3KRAGUPLyEbI04cMo3lx+
        NzAC8SEqCRobEzGs6c+BP0pwTMIXG0wq3CV1wAVtXA==
X-ME-Sender: <xms:M4WPYuFM_XOwYaqUYGd3CCgCesTRFYA5fjDBTq3sXTyukzamRBF2uQ>
    <xme:M4WPYvX9TTsnOswMWkxmbT63bfZ3g8zg1xWVL3AYey6NYi8ZyAo2ToS6p4jXM6IZa
    F6NV1P0ym1ob-0Vlqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeejgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:M4WPYoKXm912CSVbpJOFGCJQ_VfeNpOPYmIV5o-bJez0vuhlP5tUxw>
    <xmx:M4WPYoG6GdLV5SUIcWuh27Taj9T3t14prX0zzZMkPeHD_pCHomDRSA>
    <xmx:M4WPYkUTtJthoRWnkXK4rjlkzi-thUrPTOTXMOirzLe9XNCAxRtXSA>
    <xmx:NIWPYnHvNpCzbk2jJ-eJvV1PpdJUY5ppGD5H94_9u3jJQ3M5I5QlWA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A2726A60072; Thu, 26 May 2022 09:48:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <a3636e0e-a804-4701-9240-225a3131b16a@www.fastmail.com>
In-Reply-To: <20220526014107.2871787-1-robh@kernel.org>
References: <20220526014107.2871787-1-robh@kernel.org>
Date:   Thu, 26 May 2022 15:48:15 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Mark Kettenis" <kettenis@openbsd.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: apple: Add missing 'power-domains' property
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On Thu, May 26, 2022, at 03:41, Rob Herring wrote:
> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples.
>
> The Apple PCIe host has 3 power domains at least according to the example.
> Add the 'power-domains' property to the schema.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Ideally, we'd define what each power domain is, but I don't know what
> they are.
> ---

I think the example is just wrong (or outdated) and we only need a single
power-domain for pcie.

The hierarchy is ps_pcie_ref -> ps_apcie -> ps_apcie_gp and the pcie
node then only depends on ps_apcie_gp.




Sven
