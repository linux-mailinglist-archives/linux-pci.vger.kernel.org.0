Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA67DDE5F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 10:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjKAJ0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 05:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjKAJ0B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 05:26:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C9B9
        for <linux-pci@vger.kernel.org>; Wed,  1 Nov 2023 02:25:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C78C433CC;
        Wed,  1 Nov 2023 09:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698830758;
        bh=eaaJjEZhTenWLCZhye+UdansPziF4x972nE5tF/JyQI=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=UZmw6z/vuL6JUmJl8tQlkf5wuaDKMpPz2VI08X3y65Jvku38/sxZ6P3Wz4HkraOfp
         2NyjO6r35KgV8FEJcMY1hILRA9mvsxEERO45iTU10DniRzQ7Yh5i/BW3LKfzguwTu3
         UiHlcN4wAKUBm01GN/5rjoA1wrSmSKNU3KRmP/kuKPLwM/WicMnzepg8gBESiG+oRh
         I7BfqGdjurdG5c9ulS3/J2++HRtEF/cOYMTKVbh8P/+lbvD2Yitz1RBIqjrEpBhOPP
         aZ2nOFBKFolFBcDlGZD2spcwRfb2iYb7I2svqlWSJ8SvNzi12wSRxui3WdZm4d90wW
         wEsRXtL4coxZA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4A41927C005C;
        Wed,  1 Nov 2023 05:25:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 05:25:57 -0400
X-ME-Sender: <xms:pBlCZUsfqVkJDSwaiM75O706VqVtvWBhnYnqAg6FvYsK2SipFCqlLg>
    <xme:pBlCZRfROUoEhq626kXKO_ffk4zX3Mdr16JdcE2Dj4tJY7Pjed4dhDzhn1R-z8dAQ
    h4d3GBovz8Kah-OBM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtffejfeeggefgleefgfeghfehfeefffetgffgleegudevveet
    hfefjeevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:pBlCZfwIDTdGEPnGwZ9zfgKR5tDmi6WPvfLeNeqqKjHdcWB-vg4Ibw>
    <xmx:pBlCZXOn0jvcShb8PFUOJy1U_jhbqOj16DFLonpn6d90Ns8Ry-iQdA>
    <xmx:pBlCZU9iag-IS4b9exBO5LlaECpA4cAhTpSCP3ZI20oIWkYwx2VEpA>
    <xmx:pRlCZYbn7Q-c9AWYaj8IC6JjZsraK-3nE5V2dN97D5mx9xQkbo7ZcQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 86BFAB60089; Wed,  1 Nov 2023 05:25:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <da1413c0-d81a-47b6-8283-0fb3da7975e6@app.fastmail.com>
In-Reply-To: <20231031171401.GA17989@bhelgaas>
References: <20231031171401.GA17989@bhelgaas>
Date:   Wed, 01 Nov 2023 10:25:25 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Bjorn Helgaas" <helgaas@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>
Cc:     "kernel test robot" <lkp@intel.com>, linux-pci@vger.kernel.org,
        "Nathan Chancellor" <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:controller/xilinx-xdma] BUILD REGRESSION
 8d786149d78c7784144c7179e25134b6530b714b
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023, at 18:14, Bjorn Helgaas wrote:
> On Tue, Oct 31, 2023 at 09:59:29AM -0700, Nick Desaulniers wrote:
>> On Tue, Oct 31, 2023 at 7:56=E2=80=AFAM Bjorn Helgaas <helgaas@kernel=
.org> wrote:

>> >   arch/powerpc/xmon/xmon.c:             release_output_lock();
>> >
>> > That said, the unused functions do look legit:
>> >
>> > grackle_set_stg() is a static function and the only call is under
>> > "#if 0".
>>=20
>> Time to remove it then? Or is it a bug that it's not called?
>> Otherwise the definition should be behind the same preprocessor guards
>> as the caller.  Same for the below.

It would be nice to get rid of all warnings about unused
"static inline" functions and "static const" variables in .c
files. I think both these warnings got added at the W=3D1 level
for compilers that support them at some point, but are ignored
for normal builds without W=3D1 because they are too noisy.

Obviously, all compilers ignore unused inline functions and
const variables in header files regardless of the warning level.

> I don't really care whether we keep the warning or not.
>
> My real complaint is that the 0-day report fingered
> pci/controller/xilinx-xdma, which is completely unrelated, which is a
> waste of time.

I tried to figure this out but couldn't find the real reason either,
clearly there is something wrong with the reporting here, my best
guess would be that there is a spurious build failure elsewhere that
leads to this file sometimes getting flagged as a false-positive.

     Arnd
