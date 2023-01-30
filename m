Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AA9681756
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjA3RLu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 12:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbjA3RLt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 12:11:49 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0240BDD;
        Mon, 30 Jan 2023 09:11:47 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D439F5C00C8;
        Mon, 30 Jan 2023 12:11:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 12:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675098704; x=1675185104; bh=8g5jhxs1ye
        CDrjfLIf+8U8LlK1MXTqncFvTNe1mMJWo=; b=qqgWjZIs+GIIXlXlQscQhT6+Ia
        kyZGJikgz1VoROG4ltqTM8VX/1YSKTj9Czq4SeJgeKAuEdJZ8mBlkfkXic5SftJU
        iq7jyxSB+BXByUTVk7CByJBj3B3wgBOjPkDqs8MfHpxOK9be+OX0fyTGDWlG1E3e
        vtiDgLlLogvFHkYZQcif7WuSWlMHOTTD+3K2SeKoy2VX+1HnluwciIkoRFmcfw3R
        FdrYp3HdAenXZ4S44+fmYraIxm+K6WYYTxQXNI5BBxLGVsL8UNM5lebORuxILBI0
        dPVQ0F+kv/BGb9SNdrpZaEAuu8+r/Prs1K3a4ax9FEi3zxStLT5GD8gJn0OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675098704; x=1675185104; bh=8g5jhxs1yeCDrjfLIf+8U8LlK1MX
        TqncFvTNe1mMJWo=; b=kVtf/GzsRe7Ufz9KnzY7w4t8qmuSx5ze2fyXzaFvm/JC
        mg4wKHKEaSvfCk8KspwJ3Vi08vYZgnAQQxHHuQNStMx4NDHnn8iBx8X29yV2mXT+
        VtQfYMJWwyNkzTiuul+MCh0O0Wybt9uds1dPyfHI/uXh3uysVcOm6oHpHg1Vtyof
        6J/XPnFhFyp+n6oHzSS+ieuv8XjRZG0m+YTcfRdG4rvkbgjPMwrsUFraUywxIOMu
        qT8WN8Wsd/R4fHdR1yAr72izkeleJPZ+Lx6vesRmhtXnsOk4dEnnHDO0zWlitTCA
        yEwRLYL84LYJV+m2MarOKv67JeG1pZDqRQMDFvnoYQ==
X-ME-Sender: <xms:T_rXY4D1VxwvoYSgVp0iTHLfixLrNRJOXnJ_707xOpYTylAM73pDFA>
    <xme:T_rXY6ij-rFoP4n1D1sV1tfik-ne6nvazoN59pEJag_u9HUzQ1riUZcFYk-cXCeb7
    TlJOuyr7Lw_vabY6yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefg
    udfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:T_rXY7n2AH0WdgbhHdwgSwIGEHKNxu9eRjx1pbS7k_0nzd9oqUUiIQ>
    <xmx:T_rXY-yugjxUAeNrmRWeYJDU1aUCVH6a_s-MDyrY4SvXybppXrmVvg>
    <xmx:T_rXY9RGoFIPLzWaQ6wGkkdRVwN44TZujenS2kE-S-8gOzGLzGy-5g>
    <xmx:UPrXY5rZOjN1IwZu-rXrVDkWffDb9WfHYSzy86V5U4r0-OwGxuJdaw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE699B60086; Mon, 30 Jan 2023 12:11:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-106-gfe3ab13a96-fm-20230124.001-gfe3ab13a
Mime-Version: 1.0
Message-Id: <7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com>
In-Reply-To: <20230113164449.906002-8-robimarko@gmail.com>
References: <20230113164449.906002-1-robimarko@gmail.com>
 <20230113164449.906002-8-robimarko@gmail.com>
Date:   Mon, 30 Jan 2023 18:11:24 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Robert Marko" <robimarko@gmail.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>, bhelgaas@google.com,
        lpieralisi@kernel.org, "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        krzysztof.kozlowski+dt@linaro.org,
        "Manivannan Sadhasivam" <mani@kernel.org>, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Abel Vesa" <abelvesa@kernel.org>
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe node
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 13, 2023, at 17:44, Robert Marko wrote:
> IPQ8074 comes in 2 silicon versions:
> * v1 with 2x Gen2 PCIe ports and QMP PHY-s
> * v2 with 1x Gen3 and 1x Gen2 PCIe ports and QMP PHY-s
>
> v2 is the final and production version that is actually supported by the
> kernel, however it looks like PCIe related nodes were added for the v1 SoC.
>
> Finish the PCIe fixup by using the correct compatible, adding missing ATU
> register space, declaring max-link-speed, use correct ranges, add missing
> clocks and resets.
>
> Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
> Signed-off-by: Robert Marko <robimarko@gmail.com>

I was reading through the pull request today and saw this patch
along with the Gen2 one:


> @@ -871,9 +873,9 @@ pcie0: pci@20000000 {
>  			phy-names = "pciephy";
> 
>  			ranges = <0x81000000 0 0x20200000 0x20200000
> -				  0 0x100000   /* downstream I/O */
> +				  0 0x10000>, /* downstream I/O */

Fixing the length here seems fine, but the bus-side address
still looks wrong: 0x20200000 is way outside of the usual
port ranges from 0 to 0x10000 on the local bus.

> -				  0x82000000 0 0x20300000 0x20300000
> -				  0 0xd00000>; /* non-prefetchable memory */
> +				 <0x82000000 0 0x20220000 0x20220000
> +				  0 0xfde0000>; /* non-prefetchable memory */

I see the total size of the memory space is under 256MB. Are you
sure that there is no 64-bit BAR in addition to this?

I also see commit 7d1158c984d3 ("arm64: dts: qcom: sm8550: Add
PCIe PHYs and controllers nodes") introduce the same broken
I/O port range (oversized 1MB space wiht an identity map) for a
new SoC. This should probably be fixed as well, along with
reviewing the other ones.

Has the I/O space mapping on any of these actually been tested,
or just copied from one SoC to another? Very few devices actually
use I/O space, so it wouldn't be surprising if it never worked
in the first place.

       Arnd
