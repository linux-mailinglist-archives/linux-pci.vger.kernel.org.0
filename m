Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B274316F6A4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 05:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgBZEvJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 23:51:09 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:39607 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgBZEvJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 23:51:09 -0500
Received: by mail-qv1-f51.google.com with SMTP id y8so757840qvk.6;
        Tue, 25 Feb 2020 20:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aVk24eLY14K87OU1OB1xgRnj/7rTwtwPZpvkthfcADk=;
        b=d3+VJ6ImQ8PNewkBm3dvALg/VYUIIY+pxIrYJwAoNyrcT52kEPGyTX4NBdE4k+YCSR
         c0Zy3/LNfKwzOKyytGbqnInfSj+y+5fAUr/4dmLzkyYC4dZxYTFheluz26HCnrt76mr1
         4pbNbHfgppu3jRIcZlowuZ+eaFd4Uj/IreXvWwHnVw603SEW5uD8l2djXvPE94STKtbT
         KuGNFvS0fRTYSvsrDcF9Yq0ADcm0Z3qvpcjECwKDyk18HNgq0G/1exbTan3P653BH0DF
         4nXtyzJrvr4KHRT17SJ988PeR0Mtf6VEp5sfuR3wEorl559E9OTVPwwT8c0dBGQNj4t0
         TPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aVk24eLY14K87OU1OB1xgRnj/7rTwtwPZpvkthfcADk=;
        b=cILNXnMEbVai1CFF5DlpiJIr2Ash+ISHbFK6a6EfxyEKSC9XUUkN7XTWuVC1BwNCsA
         VWcvPKphAQBcmNDdD7z5B659o3i17gXduPfUZPgro7Fv8rjDVCBVEJCJY14PUi7mC9Fh
         JN95dcR0MD3nQf36bnrhVLkbyVx6cr6VP8ocXrObizVWzdHpz2eAx8DKlnsMq2+nFEkC
         +PGcYYOLMXuFW0M1RgGAIdyABrbd+YImdzE1Yw1mxEJCTAmsnJdDdDPdFrqhmLEiffrW
         WcB3aNfTHGTWfNfRey4Lo3aHm6kHnPS1ORTlu5e0w2mLVU1UrYVGfoWl6zja2rhH5sfz
         IDTg==
X-Gm-Message-State: APjAAAUXTIC7n7xnnDFF3xinAGwjIjKUbk4tb7hspvy2YlrUoHgvk2pg
        hw224Lc7YuXU2GBbjPzi/FE=
X-Google-Smtp-Source: APXvYqzrO/kdo5/NmFkfe4u8fWu+qQ+icG/nIF1hLBupDzs9uXXpSn8gx4XQs1XMp1SD1t6+YvByLA==
X-Received: by 2002:a0c:cd8e:: with SMTP id v14mr3118531qvm.182.1582692667662;
        Tue, 25 Feb 2020 20:51:07 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q5sm501066qkf.14.2020.02.25.20.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 20:51:07 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 25 Feb 2020 23:51:05 -0500
To:     Trevor Jacobs <trevor_jacobs@aol.com>
Cc:     "Michael ." <keltoiboy@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Philip Langdale <philipl@overt.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not
 working on Panasonic Toughbook CF-29]
Message-ID: <20200226045104.GA2191053@rani.riverdale.lan>
References: <20191029170250.GA43972@google.com>
 <20200222165617.GA207731@google.com>
 <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
 <20200226011310.GA2116625@rani.riverdale.lan>
 <CAFjuqNg_NW7hcssWmMTtt=ioY143qn76ooT7GRhxEEe9ZVCqeQ@mail.gmail.com>
 <6e9db1f6-60c4-872b-c7c8-96ee411aa3ca@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e9db1f6-60c4-872b-c7c8-96ee411aa3ca@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 25, 2020 at 09:12:48PM -0600, Trevor Jacobs wrote:
> That's correct, I tested a bunch of the old distros including slackware, 
> and 2.6.32 is where the problem began.
> 
> Also, the Panasonic Toughbook CF-29s effected that we tested are the 
> later marks, MK4 and MK5 for certain. The MK2 CF-29 worked just fine 
> because it has different hardware supporting the PCMCIA slots. I have 
> not tested a MK3 but suspect it would work ok as it also uses the older 
> hardware.
> 
> Thanks for your help guys!
> Trevor
> 

Right, the distros probably all enabled MMC_RICOH_MMC earlier than
upstream. Can you test a custom kernel based off your distro kernel but
just disabling that config option? That's probably the easiest fix
currently, even though not ideal. Perhaps there should be a command line
option to disable specific pci quirks to make this easier.

An ideal fix is I feel hard, given this quirk is based on undocumented
config registers -- it worked on Dell machines (that's where the
original authors seem to have gotten their info from), perhaps they had
only one Cardbus slot, but the code ends up disabling your second
Cardbus slot instead of disabling the MMC controller.
