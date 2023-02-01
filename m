Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60289685DA8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBADDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 22:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjBADDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 22:03:22 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5176876B7
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 19:03:06 -0800 (PST)
Received: (qmail 31459 invoked from network); 1 Feb 2023 03:03:04 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 1 Feb 2023 03:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=message-id
        :date:mime-version:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding; s=2018; bh=a0M/Z5vF5O+w
        u1iGce08r1mIpiAiaO7guywRu/f9N7I=; b=GasDnwLarSzqBxVVo/vpZrX9sWbF
        twAlRa48WAaAtDnQM/txXgKYfyvV2k2/+z6esolla8gFIo/t145wuFwYwLC3mfsw
        3TyfGR4hvcqbUiRQFTWt7XGk6gSRYe2yQw15DjFhYgpsIxQnr0X0rFVRCjMtm8BU
        15E6i32zXLcnqbI=
Received: (qmail 27136 invoked from network); 1 Feb 2023 03:03:04 -0000
Received: by simscan 1.4.0 ppid: 27093, pid: 27134, t: 0.3140s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 1 Feb 2023 03:03:03 -0000
Message-ID: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
Date:   Wed, 1 Feb 2023 11:02:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] wifi: ath9k: stop loading incompatible DT cal data
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org,
        linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Edward Chow <equu@openmail.cc>
References: <20230117194614.GA135447@bhelgaas>
Content-Language: en-US
From:   Mad Horse <equu@openmail.cc>
In-Reply-To: <20230117194614.GA135447@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

在 2023/1/18 03:46, Bjorn Helgaas 写道:
> On Tue, Jan 17, 2023 at 05:27:46PM +0800, Edward Chow wrote:
>> Loading calibration data from an OF device tree node not declared
>> compatible with the device (e.g. a PCI device with calibration data
>> from corresponding DT node gets replaced, so the newly installed
>> device become incompatible with the node) or driver may lead to fatal
>> result, e.g. kernel panic.
> Please include a link to a bug report and include a few lines of the
> oops or panic directly in the commit log so when users see this
> problem, they can search for the text and possibly find this fix.
>
>> The driver should check whether the DT node corresponding to the
>> device compatible with it, and load calibration data only from
>> compatible node.
> If you read this commit log carefully, it doesn't actually say what
> this patch *does*.  It has some background and this assertion about
> what drivers *should* do, but it doesn't say what this patch does.
>
> Suggest structure like this (flesh out with the relevant DT property
> names, etc):
>
>   For PCI ath9k devices, load calibration data only if there is a DT
>   node corresponding to the device with XXX ...
>
> More details: https://chris.beams.io/posts/git-commit/
>
Thanks for pointing it out. The commit log of the last two patch has been reworded with required content, and sent to the current thread earlier.

