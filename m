Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5C4EB3AA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 20:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiC2Sqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 14:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiC2Sql (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 14:46:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8928986CE
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2022 11:44:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 560041F44231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648579496;
        bh=LDk0Z17cm2cM1paSxw43eoRfnoZF6THtZ/caLXSlIP0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BcEh5f1dIDnyI+FqqDnazEpm3Uy4sUV3K8G2UgVnYNTcMxVmkIK3RTuw500N8jU59
         6CUsJB5jERMrJfU9g8m361Tiob9w3XXE77j+rDFGAGrbR9+8XSaBLE1uC2aYaRBUfQ
         /l0XTZrTqKQ2nE8xF/tf0W7XnpNHq4SAWC11ZV3ksXrhBGPLgyoCxeM5LkchYseppe
         rBSF6+Vh16PfSFu0sm7AnN0o4rKMMwOSXbvOMytF/1MPhx83bre7NewXj9x77nKONK
         1AGieRwnj9y+HNS1KEhHcG5RoZpSyAoWOyVW8FpHt70K+MzAO8vhCPmrJ0+S+8tkYI
         fC2mAs8CtxZrg==
Message-ID: <28699579-8384-ff3b-5662-fb56d8ced766@collabora.com>
Date:   Tue, 29 Mar 2022 19:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
References: <623c13ec.1c69fb81.8cbdb.5a7a@mx.google.com>
 <Yjyv03JsetIsTJxN@sirena.org.uk>
 <4e9fca2f-0af1-3684-6c97-4c35befd5019@redhat.com>
 <Yjzua8Wye/3DHBKx@sirena.org.uk>
 <f8e96f8a-c19c-6acd-2f54-688924f491e8@redhat.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <f8e96f8a-c19c-6acd-2f54-688924f491e8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2022 13:54, Hans de Goede wrote:
> Hi,
> 
> On 3/24/22 23:19, Mark Brown wrote:
>> On Thu, Mar 24, 2022 at 09:34:30PM +0100, Hans de Goede wrote:
>>
>>> Mark, if one of use writes a test patch, can you get that Asus machine to boot a
>>> kernel build from next + the test patch ?
>>
>> I can't directly unfortunately as the board is in Collabora's lab but
>> Guillaume (who's already CCed) ought to be able to, and I can generally
>> prod and try to get that done.
> 
> Ok, Guillaume, can you try a kernel with commit 5949965ec9340cfc0e65f7d8a576b660b26e2535
> ("x86/PCI: Preserve host bridge windows completely covered by E820") + the 
> attached patch added on top a try on the asus-C523NA-A20057-coral machine please
> and see if that makes it boot again ?

Sorry I've been busy with a conference.  Sure, will put that
through KernelCI tomorrow and let you know the outcome.

Thanks,
Guillaume

