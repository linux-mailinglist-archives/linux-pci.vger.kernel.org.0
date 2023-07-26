Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5D7633E0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 12:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjGZKet (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 06:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGZKes (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 06:34:48 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C9B2127;
        Wed, 26 Jul 2023 03:34:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E20615C00E1;
        Wed, 26 Jul 2023 06:34:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 26 Jul 2023 06:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690367679; x=1690454079; bh=5V
        vawHwISs141Hz7Wc6ZcS682GbwIMf1XURxVyfXwaA=; b=SwyIbga4W4OElXCLwW
        dQ8fySDusevZSkiFzdbTHnRRXEsqFLdVfkq4HqcvUjfiem0Pzvt8iMdjLgKfa7TT
        XL3lsRlfQF5yRy3VrWMjveYSAmpO19uN8J3MXkH5s26E9hX5Q0mLORsdpd3FKBsm
        uBzXdWlxeGxeGAPxezL1BQgDfxX0mdKLJKViGDXd62hR/i0Y2M4el4k6dZDD/njm
        LxBMkFH+HILy0pNIoYNcDW8Z6Vt1t/F26xHwR4ea7lI6ZbUtd40o54IS0to0q9z7
        LkTH7LZPEl+1qVc7H0pudQEmMNwJuwv5Pke13FLgHBtYF4/WbLdQrG4Bdbh6tzCM
        bsbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690367679; x=1690454079; bh=5VvawHwISs141
        Hz7Wc6ZcS682GbwIMf1XURxVyfXwaA=; b=Ke3gMf9u2YUFAs/ORmM+G9RoTjQts
        5uc0NZutEvEbvam/V3O8u7i/y20hX9xGj+t+9LQNsX7C/OZ/1wGhsatkTzq9WnaU
        QZr8J5xY68H5zGJDVNgvgURvnJGQeye3K5in4oD31xQ0SP+dYS1k3OOTSEswzZJa
        a3iL5giWfh5lZ3XMDhC57xQ+lK2wf7Pg/Q8Xe60rjFtWMCtXWyeBYyIMn5khafQl
        x2vc/cC06cBPjEjIrqDSUFKqG3xITOZTMPXBpcDQ0decV0A8KQlW8UnpacoicGsp
        HDkumj/mPQ9y4yP7Ggx4B9tqNxw8ievRLZg6ouLy2N8QU1KZMdxk/TSRw==
X-ME-Sender: <xms:v_bAZD0s3xUiYytEtjvHrnkTiv6e7ZuhRiK-pX9e-IM6NPvqcCdj_A>
    <xme:v_bAZCHA9sdY_Du2hx93Cj7v-v0aYUxm22H086LjqiFOCmMdk79Dw3oOwVZD4Wfom
    IBKXjdIMB0YXSLrd2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:v_bAZD7MeYjzDGb598tkBDT20yiZox3kdiHYKxam3sRA5TWdofBNaw>
    <xmx:v_bAZI0WZ9thZP5sHt1KABNbiglcxTEkoyvsj9NHI28DkrgTCiVjtQ>
    <xmx:v_bAZGEMZ1V-GJEMmiiBdqATuqz92TxYWDKoI26fy9sNsgpBhswMgA>
    <xmx:v_bAZJD0UriU7nIVeI2tcJeSFTA94hvagmTH-iVaQN1GxlycHxxaLQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 32B8DB60089; Wed, 26 Jul 2023 06:34:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <40807832-9e26-403a-b7b7-3979d4984b23@app.fastmail.com>
In-Reply-To: <CA+G9fYuEVLeJX485ZbPNnvbViYUecNsewGiMi+54mNVnL-XBGA@mail.gmail.com>
References: <CA+G9fYtAi8NQ_5LNku3oik6b0243xhGFt2WyxERNE+eNqLbNOw@mail.gmail.com>
 <76665dd9-1cbc-4b3a-b466-18a54cd74c1c@app.fastmail.com>
 <CA+G9fYuEVLeJX485ZbPNnvbViYUecNsewGiMi+54mNVnL-XBGA@mail.gmail.com>
Date:   Wed, 26 Jul 2023 12:34:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        linux-pci@vger.kernel.org
Cc:     "Dan Carpenter" <dan.carpenter@linaro.org>,
        =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>,
        "Benjamin Copeland" <ben.copeland@linaro.org>
Subject: Re: x15: Unable to handle kernel NULL pointer dereference at virtual address
 00000004 when read : pci_generic_config_read
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023, at 11:59, Naresh Kamboju wrote:
> On Tue, 20 Jun 2023 at 14:10, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Tue, Jun 20, 2023, at 10:00, Naresh Kamboju wrote:
>> > We have been noticing the following kernel crash on x15 device while running
>> > LTP fs proc01 testing with Linux stable rc 6.x kernels.
>>
>> Do you know if this is a regression with this kernel version compared
>> to older kernels running the same tests, or an added testcase in LTP
>> that exercises a code path that may have been broken for longer?
...
>>
>> I have not disassembled the vmlinux file, but I can see that the
>> offset into the NULL pointer is '4', which does not match the
>> structur offsets for bus->ops or ops->map_bus.
>>
>> I also see that if map_bus returns NULL, we treat that as
>> an error, but if it returns '4', that is taken as a pointer,
>> which is my best guess at what is happening here.
>>
>> map_bus() seems to be either dw_pcie_other_conf_map_bus() or
>> dw_pcie_own_conf_map_bus(), since the dra7 does not have its
>> own variant but inherits these from the dwc pci driver.
>>
>> I think this is caused by the combination of two bugs:
>>
>> - something prevents the dra7-pcie driver from probing the
>>   device correctly, ultimately failing with the "failed to
>>   request irq" message.
>>
>> - The error handling in dra7xx_pcie_probe() fails to clean
>>   up after the first problem, leaving the PCIe host
>>   in a broken state instead of removing it entirely.
>
> The reported kernel crash is continuously happening on the
> BeagleBoard x15 device while running LTP fs tests on stable rc 6.4.7-rc1.

Ok, so you think there is an additional regression between
6.4.6 and 6.4.7-rc1? on top of the two that you have not bisected?

I don't see any changes in drivers/pci/ after 6.4.5, so I'm
even more confused now.

> soundcore display_connector
> [ 1195.601104] CPU: 0 PID: 4876 Comm: proc01 Not tainted 6.4.7-rc1 #1
> [ 1195.607330] Hardware name: Generic DRA74X (Flattened Device Tree)
> [ 1195.613464] PC is at pci_generic_config_read+0x34/0x8c
> [ 1195.618621] LR is at pci_generic_config_read+0x1c/0x8c

This looks identical to the first bugs that you reported, so I'd
suggest you keep trying to narrow down when that one started rather
than looking at the latest stable-rc.

     Arnd
