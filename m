Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9E697DDC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBONvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 08:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBONvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 08:51:16 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02222B083
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2023 05:50:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D26D5C0179;
        Wed, 15 Feb 2023 08:50:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 08:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676469040; x=1676555440; bh=55M0LOKamm
        aIqjTX10c7MKzxqCX1wkKOCsf80qHeDVA=; b=uHS5SCcvksxfcxIu4cLL/xkbjL
        W76bCjolSWy+SqMJaeWQdhj5z1ISviJmp9R6tshoa+sG259kzUPiwFBBO4bKoTKm
        6K0IIVXahuxUtDqQGV1DjXeEZkh4JtI+42brOILafeDHS6Mc0VfMhlpVwjsNcVeG
        O4ZVpNIM58XwwSjjwJPC/AryLYBNE1BadNn8fo5agk214t53wHolWFy6sU6esAGp
        od82cBUKq631457ue3vxg5pUzChUYKWv0f3zNB2qFI7sBVipdR+bYg0lf0ZruVGM
        tCc2xbaWyeYuIhpU+TwUidxzTklvbGJDHy4ggJBl79S74y9kINACvi9g014Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676469040; x=1676555440; bh=55M0LOKammaIqjTX10c7MKzxqCX1
        wkKOCsf80qHeDVA=; b=jNZg6+ngRfgzyA4rV64qf783vFKb2Gu6uzl7je79X1sO
        RExjxrncN+6xzdboOeoLbdiZuuDL0JmNLLApFM+YeCt3eg4L9owzZQcsnUHSGxR3
        s5XL2T/7dqxR8XPxf/Z05cadQcqPDegtHy89tbXvOte2L7/nHoXq6ZeP3uj1i04F
        +hDjiIVsTH8L3sC7iS4cf+gL7EAsSDO9rJm4lJd5kyj5CBSv35rYS4LF9x7lDc9M
        x3WCaSvZLtxF7X9bm8G2KdbnvtsdLg2ZlknVVSeDRh6WASjI2WrqipSSY0cE62Qi
        HPcg+isxYxo3+gQzRfBYN8LOU17B6ZVh3wwaIqtDgg==
X-ME-Sender: <xms:L-PsY8QDkBD1JY75Z6mhmr_oivYiZDaTKBpw9EooMzzy5FqwGZcebA>
    <xme:L-PsY5zOWSmQ9xBPqwtdMXQMaDcwT_sDJrH0Hnd4iulHoo3Izz6cK1YHQ51fiG67Z
    IBPwm1LUHpdi7VdZNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:L-PsY514DQK-EKFhEQLS92kMkgeGmBeQqQcZmyW7N4-yTYb5Z9-d2w>
    <xmx:L-PsYwDVuJVp3nwfN_g-sMNx0OuiXCIFzQfE9S0j52OH7hq7t4iiTg>
    <xmx:L-PsY1h1VGdz_-S1UqkXHzgReiMPU4P6Y9qCD_GOADF7tRNf-Pyhaw>
    <xmx:MOPsYwXi1TQztyjZ9wc_vBaMtnYQ8qK7XJeu2U9ptTTEED0iSE8KyQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8E978B60086; Wed, 15 Feb 2023 08:50:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <c49df2f9-9848-45aa-9d64-9e4e9841440f@app.fastmail.com>
In-Reply-To: <Y+zdD8G0NJIdiClo@kroah.com>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-8-damien.lemoal@opensource.wdc.com>
 <Y+zDUmwj8+ibp3r0@kroah.com>
 <e71ad0dc-2250-7ffc-6d96-745e2da40694@opensource.wdc.com>
 <Y+zJqp9cXelKro6t@kroah.com>
 <077adda6-ef9f-5c31-c041-97342317f1d2@opensource.wdc.com>
 <Y+zdD8G0NJIdiClo@kroah.com>
Date:   Wed, 15 Feb 2023 14:49:52 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rick Wertenbroek" <rick.wertenbroek@gmail.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>
Subject: Re: [PATCH 07/12] pci: epf-test: Add debug and error messages
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023, at 14:24, Greg Kroah-Hartman wrote:
> On Wed, Feb 15, 2023 at 09:18:48PM +0900, Damien Le Moal wrote:
>> On 2/15/23 21:01, Greg Kroah-Hartman wrote:
>> >>>> @@ -330,6 +330,10 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test, bool use_dma)
>> >>>>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>> >>>>  	volatile struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
>> >>>
>> >>> note, volatile is almost always wrong, please fix that up.
>> >>
>> >> OK. Will think of something else.
>> > 
>> > If this is io memory, use the proper accessors to access it.  If it is
>> > not io memory, then why is it marked volatile at all?
>> 
>> This is a PCI bar memory. So I can simply copy the structure locally with
>> memcpy_fromio() and memcpy_toio().
>
> Great, please do so instead of trying to access it directly like this,
> which will break on some platforms.

I think the reverse is true here: looking at where the pointer comes
from, 'reg' is actually the result of dma_alloc_coherent() in the
memory of the local (endpoint) machine, though it appears as a BAR on
the remote (host) side and gets mapped with ioremap() there.

This means that the host must use readl/write/memcpy_fromio/memcpy_toio
to access the buffer, matching the __iomem token there, while the
endpoint side not use those. On some machines, readl/write take
arguments that are not compatible with normal pointers, and will
do something completely different there.

A volatile access is not the worst option here, though this conflicts
with the '__packed' annotation in the structure definition that
may require bytewise access on architectures without unaligned
access.

I would drop the __packed in the definition, possibly annotating
only the 64-bit src_addr and dst_addr members as __packed to ensure
the layout is unchanged but the structure as a whole is 32-bit
aligned, and then use READ_ONCE()/WRITE_ONCE() to atomically
access each member in the coherent buffer.

If ordering between the accesses is required, you can add
dma_rmb() and dma_wmb() barriers.

     Arnd
