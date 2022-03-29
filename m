Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7896F4EB5B0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 00:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiC2WP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 18:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiC2WP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 18:15:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21806186FA6
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 15:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1341B81A9A
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 22:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4811EC340ED;
        Tue, 29 Mar 2022 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648592048;
        bh=iRxdJc6hq33OJ8nbZHjA3BvKF674SnL3GyDCH8wum+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QeNF7nP6/U5sCedxUftGZwWIGQ1O7XZdfA728cjnK9S9KQFWtNlzvanLddqAksU+g
         MOI6e+DpcCnXIkA9DUl1fXcng/OdLcJjXr130pTaAULqXSXCPB9Gd3SM3I6QAD420l
         ZZK9N5rMeKebxzNju+BFgGNjlB/3owMzqDdfpewadha8DZJa268rou5JyKhv3TmtGq
         iJ+UwpoJ+1s4GKX4ItdHpUaNDLx03jj+wH/J0aWDWdWg00xd953LbX5yq/eiqiDKwI
         JQSnY0BiG8nVSClHvX5sR2c7S2VK62n4csQwyH+vtHkogkebFDaCDNSSlZ50xaOAzg
         a3UDBkPuOnwFw==
Date:   Tue, 29 Mar 2022 17:14:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <20220329221406.GA1638556@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjyv03JsetIsTJxN@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 05:52:19PM +0000, Mark Brown wrote:
> On Wed, Mar 23, 2022 at 11:47:08PM -0700, KernelCI bot wrote:
> 
> The KernelCI bisection bot has identified commit 5949965ec9340cfc0e
> ("x86/PCI: Preserve host bridge windows completely covered by E820")
> as causing a boot regression in next on asus-C523NA-A20057-coral (a
> Chromebook AIUI).  Unfortunately there's no useful output when starting
> the kernel.  I've left the full report below including links to the web
> dashboard.

Details for the archives, since I got these via private email while
traveling (thanks, Guillaume!):

> On 28/03/2022 09:08, Guillaume Tucker wrote:
>> On 27/03/2022 21:38, Bjorn Helgaas wrote:
>>> I dropped other recipients because I'm traveling and can't easily
>>> send plain text email.
>>>
>>> If there are logs of the last good commit from these bisects, could
>>> you add links to the thread?
>>
>> The logs from each bisection step aren't kept in KernelCI but they
>> could be found in the test lab archives directly, I'll take a look.
>>
>> Otherwise, details for this regression can be found here:
>>
>>   https://linux.kernelci.org/test/case/id/6239d0afe9d42800692172dd/
>
> Actually here's all the test jobs for this bisection:
>
>  https://lava.collabora.co.uk/scheduler/device_type/asus-C523NA-A20057-coral?dt_search=lava-bisection-161
>
> The last passing one is from iteration 13:
>
>  https://lava.collabora.co.uk/scheduler/job/5937945
>
> I've attached the full log as a text file since the web UI for
> the lab is sometimes very slow.  Hope this helps.
