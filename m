Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A84110557
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 20:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLCTlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 14:41:45 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:34099 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfLCTlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 14:41:45 -0500
Received: by mail-io1-f45.google.com with SMTP id z193so5160341iof.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Dec 2019 11:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBemf5DffbM9H45GJNpf6XQTgytqS7SHwtWxDozwP2k=;
        b=Zn6/mtS46CfYNTBvL+G3gsuGdj1yDZoKrME2Cm0wMQCY5fjcoWvefbN1CLMGjmOJA1
         9WC2PCtFU8/4Vfd86+YWCUQIvD9IOjXz34uyx/oizThOidMc1Rr0u0foU+ENh1eWzRRd
         6l8ow8Ls2e3YVJifDJ0mtA6n/3ev0jFO8JJ+Tetw55fE3BZW/65tDfu58DYHWpL900Hb
         z5JrdoFih7F7WjFZ6OB4c0Tm/Qbd8PQ3GaRoIQa9kfq1Db5dV1NprGktZwf6GGHsNcmE
         YGHLmKd1Je58e3wvoMtiPxTd4xKzZD57TXT4CL0ZVrlbTrU3JZaYltoYxGOJIFmjwp54
         a48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBemf5DffbM9H45GJNpf6XQTgytqS7SHwtWxDozwP2k=;
        b=mj4UDWFvPwXGHQQx/c/m9+8yQ+L9WYlMCKREXw5Y09p8so/voWP2WCa3qo/g+mIttj
         S06gvOxb6L64d5r2vKuVYLze9b3w0RDZyskpUTIG/IAqnZU+TqKes/j4R1+2KB8oM+08
         LGtLIF2WtPcy9Q2o4nAWk/4pPqd6lovI3X4AU5c8h0saQ+Co5ME0lWout3bCgnRBau/k
         OafiaaSRDFjShAb8X4gJuMT63Z04KrcQZ3bMSJ8AwdLlZdfjgL+jwZ7dNZPer0UakeCa
         5NYIjEqrHcIVktSwuqp91PssVowFFy4BT0c4217wghrLGMc9G2QatbgY+IYqVmYFG1Zl
         Mnbw==
X-Gm-Message-State: APjAAAWgJef9RjhAKULmnWm+ngGqELET0YJmp9px3ozslcRO/5oSgrt+
        o1qMRyzSEeKI5fVIz/FL/rfSNSC0w4ADehZO4CJ4gw==
X-Google-Smtp-Source: APXvYqwxkVJgS3InUv5/LmPbRiof3P9j+j9W7/spqafHaIbJnIhprxg1ULJPZZFP78UueZBNHl/exmw8VSDIniSdL/k=
X-Received: by 2002:a5d:9913:: with SMTP id x19mr3905793iol.46.1575402104183;
 Tue, 03 Dec 2019 11:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com> <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
In-Reply-To: <CALCETrWUYapn=vTbKnKFVQ3Y4vG0qHwux0ym_To2NWKPew+vrw@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 3 Dec 2019 11:41:32 -0800
Message-ID: <CACdnJuv50s61WPMpHtrF6_=q3sCXD_Tm=30mtLnR_apjV=gjQg@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        X86 ML <x86@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 3, 2019 at 7:30 AM Andy Lutomirski <luto@amacapital.net> wrote:

> Would a similar patch apply to non-EFI boot?  That is, in a BIOS boot,
> is busmastering on when the kernel is loaded?

It's only relevant where firmware configures the IOMMU but then
removes that configuration before handing control to the OS. I'm not
aware of that happening anywhere other than EFI.
