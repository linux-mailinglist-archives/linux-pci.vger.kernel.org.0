Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB0409E4D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbhIMUpv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbhIMUpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 16:45:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9BC061574;
        Mon, 13 Sep 2021 13:44:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q26so16637740wrc.7;
        Mon, 13 Sep 2021 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uJ9c1gaOud7sGqjyc47QBp3YqMF6hd2J1/zaJtx/Ook=;
        b=XraguzSr9PUzOKTgdLzhNj8bzEBq9hUewu56ASfelTOo9DNQsc1nWwYOs5NYIewkvP
         PsAoxqVGfjQpWITjgfKcYI8AgwIsoX1j3ukVolOlSXtPJw8HmkNajioHlXq75HZZWK1j
         b2GHBQTn+9ZefbYmulECych9NQtmrdkVw5JzaAkjEyq5W7zf1s8rSI8owf7vbg5oygiz
         bOHWVZSW0o+GHrhSONWKMAEWx8+TZk0MwNCJCENFCanFANMGs7RyvaYzh3nGqOPvkRZ/
         IEK9kiADTzdXfekuzq6i1LgIWyDeLUmRlNa9N6/qrxIJt4jS1J1SNU/H4ekmsgFjmUm7
         usIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uJ9c1gaOud7sGqjyc47QBp3YqMF6hd2J1/zaJtx/Ook=;
        b=3yiyD73OKIEXgUjVXFak9plMpvKBUuQWnjkM32qER1IGYOY0Go9WAUFx1RwdMCPMdo
         /0/BveFy+sGgLTeWx8dM0gsut1GLVuIVWO+dzbvxE7qQja8L3kmnhoffQOP4bv2uQk2v
         t6cMFllgdU260vlatSo/RqrZtem36t9rJSGvNe08ilUq+EC4q7F2iTpc+YkUccCbOdDy
         Kfj0sgKmENeWgzioT26kTzFw+5iLtIZsoVAY9me9aNQCFZamJHl1/iGiWJ3cvMY8pxRH
         LSoFGx7XKNMZtQ3YvZjVk+VewN4pLK7d7TGD9uD5iiPaIk9Hcu6iXgstcGn1VoP74gGh
         DSPQ==
X-Gm-Message-State: AOAM530HNvupOB+wurixZWXd7RUwKEaRDd9wX1Iqr+nFfF18az6bkDvN
        QhoL3GMYXewrP1SabE6QsFc=
X-Google-Smtp-Source: ABdhPJwwTDWKWy2rTddonQ03xI/9YwGXWx2yyaKiUz0pNEzkcRz9oJhzivq4zPD4my4WgsgDIi60OQ==
X-Received: by 2002:adf:b785:: with SMTP id s5mr14648213wre.30.1631565873252;
        Mon, 13 Sep 2021 13:44:33 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:2517:8cca:49d8:dcdc? (p200300ea8f08450025178cca49d8dcdc.dip0.t-ipconnect.de. [2003:ea:8f08:4500:2517:8cca:49d8:dcdc])
        by smtp.googlemail.com with ESMTPSA id g5sm8407167wrq.80.2021.09.13.13.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:44:32 -0700 (PDT)
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Linux 5.15-rc1 - 82599ES VPD access isue
Message-ID: <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
Date:   Mon, 13 Sep 2021 22:44:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913203234.GA6762@codemonkey.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.09.2021 22:32, Dave Jones wrote:

+ Jesse and Tony as Intel NIC maintainers

> On Mon, Sep 13, 2021 at 10:22:57PM +0200, Heiner Kallweit wrote:
> 
>  > > This didn't help I'm afraid :(
>  > > It changed the VPD warning, but that's about it...
>  > > 
>  > > [  184.235496] pci 0000:02:00.0: calling  quirk_blacklist_vpd+0x0/0x22 @ 1
>  > > [  184.235499] pci 0000:02:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)                                                                                           
>  > > [  184.235501] pci 0000:02:00.0: quirk_blacklist_vpd+0x0/0x22 took 0 usecs
>  > > 
>  > With this patch there's no VPD access to this device any longer. So this can't be
>  > the root cause. Do you have any other PCI device that has VPD capability?
>  > -> Capabilities: [...] Vital Product Data
> 
> 
> 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
>         Subsystem: Device 1dcf:030a
> 	...
> 	        Capabilities: [e0] Vital Product Data
>                 Unknown small resource type 06, will not decode more.
> 

When searching I found the same symptom of invalid VPD data for 82599EB.
Do these adapters have non-VPD data in VPD address space? Or is the actual
VPD data at another offset than 0? I know that few Chelsio devices have
such a non-standard VPD structure.

> 
> I'll add that to the quirk list and see if that helps.
> 
> 	Dave
> 
Heiner
