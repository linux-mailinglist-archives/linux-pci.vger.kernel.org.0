Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6990254557B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiFIUV5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFIUV4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 16:21:56 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E340A31;
        Thu,  9 Jun 2022 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kex7A90sDxCaEnRPdpCb3MZDyexLHqLLb1ZhhbFZT/E=; b=JnoquEGDCaiTMvR/u87va8Xsck
        ttW3vdleoqFUyDTKN/28+J61DpqOkKyBj+AkFNy8XeyEv1qh3/iUSXZ8U01KRU+akUiEFAQ+urxC9
        t+Gr0itf/utp1aamvu8ld5Adoek6/d//A1wzzI+w8VJF7Xijj10BvEwhI21FkoSoNN3FE/ySz6pKa
        GSjM8luCeQewnq9jT+wakks0a2ocQM/rPclKjGY01vtZ1/0yQu8I+m1Y6/ItbSczNb4lBTxo1UvPf
        5qTYzzI2PBIrvCEkW4TpDcKWz+6AQSufBnWBmNs6s7+QVtN8F+Pom9+nCMBmmvFHbIfweg+vBBD8d
        EgyyRRNA==;
Received: from [179.110.79.194] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nzOf0-00FWyO-6J; Thu, 09 Jun 2022 22:21:42 +0200
Message-ID: <67f021ff-b54c-3e84-756a-d0044d633007@igalia.com>
Date:   Thu, 9 Jun 2022 17:21:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] powerpc/pci: Add config option for using OF 'reg' for PCI
 domain
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Guowen Shan <gshan@redhat.com>
References: <20220609193451.GA525883@bhelgaas>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220609193451.GA525883@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

First of all, thanks for looping me Bjorn! Much appreciated.
I'm also CCing Ben and Gavin, that know a lot of PPC PCI stuff.


On 09/06/2022 16:34, Bjorn Helgaas wrote:
> [...]
>>>>>>>>>> Upgrading powerpc kernels from LTS 4.4 version (which does not
>>>>>>>>>> contain mentioned commit) to new LTS versions brings a
>>>>>>>>>> regression in domain assignment.
>>>>>>>>>
>>>>>>>>> Can you elaborate why it is a regression ?
>>>>>>>>> 63a72284b159 That commit says 'no functionnal changes', I'm
>>>>>>>>> having hard time understanding how a nochange can be a
>>>>>>>>> regression.
>>>>>>>>
>>>>>>>> It is not 'no functional change'. That commit completely changed
>>>>>>>> PCI domain assignment in a way that is incompatible with other
>>>>>>>> architectures and also incompatible with the way how it was done
>>>>>>>> prior that commit.
>>>>>>>
>>>>>>> I agree that the "no functional change" statement is incorrect.
>>>>>>> However, for most powerpc platforms it ended up being simply a
>>>>>>> cosmetic behavior change. As far as I can tell there is nothing
>>>>>>> requiring domain ids to increase montonically from zero or that
>>>>>>> each architecture is required to use the same domain numbering
>>>>>>> scheme.

Strongly agree here in both points: first, this was not a "no functional
change" thing, and I apologize for adding this in the commit message.
What I meant is that: despite changing the numbering, (as Tyrel said)
nothing should require increasing monotonic mutable PCI domains. At
least, I'm not aware of such requirement in any spec or even in the
kernel and adjacent tooling.


>>>>>> [...]
>>>>>>> We could properly limit it to powernv and pseries by using
>>>>>>> ibm,fw-phb-id instead of reg property in the look up that follows
>>>>>>> a failed ibm,opal-phbid lookup. I think this is acceptable as long
>>>>>>> as no other powerpc platforms have started using this behavior for
>>>>>>> persistent naming.
>>>>>>
>>>>>> And what about setting that new config option to enabled by default
>>>>>> for those series?

I don't remember all the details about PPC dt, but it should already be
restricted to pseries/powernv, right? At least, the commit has a comment:

/* If not pseries nor powernv, or if fixed PHB numbering tried to add
 * the same PHB number twice, then fallback to dynamic PHB numbering.*/

If this is *not* restricted to these 2 platforms, I agree with Pali's
approach, although I'd consider the correct is to keep the persistent
domain scheme for both pnv and pseries, as it's working like this for 5
years and counting, and this *does* prevent a lot of issues with PCI
hotplugging in PPC servers.


>> [...]
>>> I forgot to ask before about the actual regression here.  The commit
>>> log says domain numbers are different, but I don't know the connection
>>> from there to something failing.  I assume there's some script or
>>> config file that depends on specific domain numbers?  And that
>>> dependency is (hopefully) powerpc-specific?
>>
>> You assume correct. For example this is the way how OpenWRT handles PCI
>> devices (but not only OpenWRT). This OpenWRT case is not
>> powerpc-specific but generic to all architectures. This is just one
>> example.
> 
> So basically everybody uses D/b/d/f for persistent names.  That's ...
> well, somewhat stable for things soldered down or in a motherboard
> slot, but a terrible idea for things that can be hot-plugged.
> 
> Even for more core things, it's possible for firmware to change bus
> numbering between boots.  For example, if a complicated hierarchy is
> cold-plugged into one slot, firmware is likely to assign different bus
> numbers on the next boot to make room for it.  Obviously this can also
> happen as a hot-add, and Linux needs the flexibility to do similar
> renumbering then, although we don't support it yet.
> 
> It looks like 63a72284b159 was intended to make domain numbers *more*
> consistent, so it's ironic that this actually broke something by
> changing domain numbers.  Maybe there's a way to limit the scope of
> 63a72284b159 so it avoids the breakage.  I don't know enough about the
> powerpc landscape to even guess at how.

I don't considereit breaks the userspace since this is definitely no
stable ABI (or if it is, I'm not aware and my apologies). If scripts
rely on that, they are doing the wrong thing it seems.

With that said, I'm definitely not against improving the situation with
Pali's KConfig - just think that we somehow should keep the persistent
behavior for powernv and pseries.
Hopefully PPC folks has more to say on that!
Cheers,


Guilherme
