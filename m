Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC17C53AA9D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355111AbiFAQAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353330AbiFAQAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 12:00:48 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35339AE6B;
        Wed,  1 Jun 2022 09:00:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A04C85C0194;
        Wed,  1 Jun 2022 12:00:45 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Wed, 01 Jun 2022 12:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1654099245; x=
        1654185645; bh=ZYH3e3AgsGaCCagzNdu3Jkw0DftFDdw0eqZmZz620FY=; b=h
        rhLyaFAsAk33UB/oN3XtNLwDt9df2T2yFMjiX+UtxljZY+RtO4N6LNy7OriLZgxt
        C6m87CPGqJaCNEgU2+Ue9YGq3TVTHuSHGtp7mdIG/U/CDRwUwnI11GCN4qw+kNOd
        HKYWWXwCyMihOmp9n0XbkKhWtwX6qs6F01FhR1uhsqFGGM+Sjw6owectHumA6Ave
        UL31N1mO2+rUaivIJ//S/JOycQc2PpVb4qpiiu5EADnJRt7qtS8Y2+q+kgGbcncN
        87xl6RRuqjtUl5vRM7jSParz8iEE0oM28P2+5+CuibFlkM79abyzYs4Asafg0qEy
        pg+aZH/4+v9zLKWLox8vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654099245; x=
        1654185645; bh=ZYH3e3AgsGaCCagzNdu3Jkw0DftFDdw0eqZmZz620FY=; b=o
        lfBoW3j//UwVE763/l0acB/7KF3NJ/Qhkw0cBJ/vreTKo+4pHz0oClg0OMRQGPZj
        GBm4u8rT8/uwsjKSFJlDxYzzrOKgYnuZtUPmpQhpXVm2uISkVxP7uhWPsNwLYTWZ
        dHuiUpVdT+plohMGRbk4cr51ZeQvETgXKHHNqYcCHdkhQBv8V20WQbJ/IFYybYma
        YDLZS7ZiAc3+69DSSaHiWQd1kGrszu0j/IQq7KxJyVcrVT2hLVjadJiEsAWYjhwM
        XfNhwRWMM6jjtjTl8CJNRSal7VzEf9XrqSJlLmrWvu7pIE3TGafgdQQJ84GzIU9e
        fCs0uRgKDEiNMhpV/YbMw==
X-ME-Sender: <xms:LI2XYhOpCGuL7clCVLSlkrFl2vEYNGgBrtupc3CB-igEaOT_2I65yQ>
    <xme:LI2XYj8rEfoNjCx8EQVSflx7o8_99q_pqPAMtNA32WQuDz4Eqfv6e5TKUfK6RzWRb
    AT_3WM3Ul95gHK8GEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhhmtderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfevveetfeevkeetfffhjefgveehteffjeeghefgjeefteeltdejgeff
    jeeuhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:LI2XYgRcnl00r3EUy_LYnwLJlRqnj8nvVoo_DH430PGgaxb9CxO3SA>
    <xmx:LI2XYtsxrLP7QIEo3bk3vPEsv5JATke3IEDPuBYP5Ut1zf_es6Ad_g>
    <xmx:LI2XYpfAQ1Ht4EuBWNMUTOaBRaYxRoTc_uQQYhBlLmv9-IYsgvwoTw>
    <xmx:LY2XYjsDqMtLfR-h-Ax0sBOjRkza02uxaS8vXQHPonxUBPpulCM_fg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 550D4A60072; Wed,  1 Jun 2022 12:00:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <9F092ADE-6890-40A0-8506-D19B4C49BB5F@svenpeter.dev>
In-Reply-To: <20220531215815.2408477-1-robh@kernel.org>
References: <20220531215815.2408477-1-robh@kernel.org>
Date:   Wed, 01 Jun 2022 18:00:44 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: apple: Add missing 'power-domains' property
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On 31. May 2022, at 23:58, Rob Herring <robh@kernel.org> wrote:
>=20
> =EF=BB=BFThe 'unevaluatedProperties' schema checks is not fully workin=
g and doesn't
> catch some cases where there's a $ref to another schema. A fix is pend=
ing,
> but results in new warnings in examples.
>=20
> The Apple PCIe host schema is missing 'power-domains' in the schema.
> The example has 3 power domains. However, this is wrong too as actual
> dts files have a single power domain and Sven confirmed 1 is correct.
>=20
> Cc: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Sven Peter <sven@svenpeter.dev>
