Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7068792F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 10:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjBBJmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 04:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjBBJmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 04:42:42 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795AE84B49;
        Thu,  2 Feb 2023 01:42:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CB8D05C01F4;
        Thu,  2 Feb 2023 04:42:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 02 Feb 2023 04:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675330954; x=1675417354; bh=k3VXs2ex6j
        qQ7XWdM7kwaGWtc7xwL/VmLjlXlTq3OsQ=; b=AFcVJGTxLr6QCzpK4cTk+DK5Kz
        AcbEoSSdOFHCGUcBDR3/Ks1VIOde7Wn3TjvyLGIqDG8jPlVCGVBY4KRZaO4lUWRq
        ilm4GYQPmo6QkR11h/i/WXehdkSZWqhnyYXVLIm9v0TmtIyu2R84I7KJwc16bTZ5
        BXG3HZjxMN4CQ4Xyg3ci/ySVtL4mJ//Y+c06w7Lm6ag7PyPV4wUh3e7Qn3N3dxFO
        nriGNM9rXLBA1nSn26h5pzROV7W5G5b2vERarsONq7cEap7YQ4vH478uFbIdulO8
        I5/dbah6ptKiBi3cyMqUEUAMjYCcKSFCE7dfEga+LkUviizfBWk3fm6HHFHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675330954; x=1675417354; bh=k3VXs2ex6jqQ7XWdM7kwaGWtc7xw
        L/VmLjlXlTq3OsQ=; b=ULHViyUnMuGqPA21eFcUIMNbkxJMB6Z+i9munubaO6rL
        XFmHYCkhPXS6mkAJkZLiYPqMpOG8hUeWFmhhL0JYiXdb51SZzx+wm7xqWBpzLVBY
        5fAxSFgyamcD2rbCS3OUOLy2EUjoklJlKNp1QgXsNOH8wIEHELcYSdQPunMFcXBp
        wYDLpc7+eRAIbe93/cQf0gy7eMN0V0w8ZI6MGJIKC+zeMFQYUqqX1QWLeY+JBQbV
        vTq4a6Qq8mDveWA71YBuRy0MEqZuIp0c8EBqilscSJxEX+VZjtE3tx2TZW2qFXYQ
        1AoJqAbFBVinTjsx9DPxsX4Ik6hsNkstD7OR+hQW9Q==
X-ME-Sender: <xms:ioXbY0-RoacTRTYutOfTC0LyQSfUKdxg45S2RsoFhlFJAh4L3v8hDw>
    <xme:ioXbY8v0IUciI0JHHzUdRJD3UgEec0yhilYCHlip36Gn8QAvMNEalzLkpB7_xsU-s
    WL90jqJMe6tbhDaWKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefkedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ioXbY6D053doS3ayJQVMyDK-UZHLw_N6k3qri2dkszxRDkWP0hI1HQ>
    <xmx:ioXbY0dU7vs-66bv52w-9GDv9lzPUdc31gtH6WGaTTgNPvw_E5_c_A>
    <xmx:ioXbY5Nw6eMlXDkAJ0xOumHi8g-NnOR_ggSB3iznj7vLgnqYAp5FrA>
    <xmx:ioXbY2csCBjivqo-tUc7tNRqM3WOh16ZMWZCe9s2WAU8y6P-NRqpQA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2141BB6044F; Thu,  2 Feb 2023 04:42:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <968c056c-74f9-4a8f-b662-51f60df93694@app.fastmail.com>
In-Reply-To: <CAOX2RU5Y642gWMSaK6fJ2tz=9N2AO-1fFhL5=wfLeTWWkVjz7Q@mail.gmail.com>
References: <20230113164449.906002-1-robimarko@gmail.com>
 <20230113164449.906002-8-robimarko@gmail.com>
 <7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com>
 <CAOX2RU5Y642gWMSaK6fJ2tz=9N2AO-1fFhL5=wfLeTWWkVjz7Q@mail.gmail.com>
Date:   Thu, 02 Feb 2023 10:42:15 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Robert Marko" <robimarko@gmail.com>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>, bhelgaas@google.com,
        lpieralisi@kernel.org, "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        krzysztof.kozlowski+dt@linaro.org,
        "Manivannan Sadhasivam" <mani@kernel.org>, svarbanov@mm-sol.com,
        shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Abel Vesa" <abelvesa@kernel.org>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq8074: fix Gen3 PCIe node
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 2, 2023, at 10:16, Robert Marko wrote:
> On Mon, 30 Jan 2023 at 18:11, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Jan 13, 2023, at 17:44, Robert Marko wrote:
>
> As pointed out in the commit description, the ranges property was copied
> from the QCA-s downstream 5.4 kernel [1] as I dont have any documentation
> on the SoC.
>
> I have runtime tested this on Xiaomi AX3600 which has a QCA9889 card on the
> Gen3 PCIe port, and on Xiaomi AX9000 which has QCA9889 on Gen2 port
> and QCN9074 on the Gen3 port and they are working fine.

Neither of those use I/O ports though, nor does any other sensible
device that was made in the past decade.

The compatible string tells me that this is a designware pcie block,
so I think driver actually sets up the mapping based on the ranges
property in DT in dw_pcie_iatu_detect() and dw_pcie_iatu_setup(),
rather than the mapping being determined by hardware or firmware
in advance.

Not sure about the general policy we have for this case, maybe the
pci controller or pci-dwc maintainers have an idea here. I would
think it's better to either have no I/O ranges in DT or have
sensible ones than ones that are clearly bogus, if the controller
is able to set up the ranges.

     Arnd
