Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6FD18EC2E
	for <lists+linux-pci@lfdr.de>; Sun, 22 Mar 2020 21:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCVUfI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Mar 2020 16:35:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44520 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVUfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Mar 2020 16:35:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id z3so13956883edq.11;
        Sun, 22 Mar 2020 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+1MxSbfv7IX5t2AzTeEksKn+lUCwLfRaz02Xo40oyE=;
        b=DE7Tmiu+iaa4ir3fmjEDCWhZvlCNT70QegrwRZVBG0gutmbKfKnp+AT+nwA7ycm6Hf
         Lp4wXBuek8Mtp9QxMPMduFDHfBH0KY3wvDSryvJ3Ndug+uOPoSyim6liBncb2jnNQbSc
         R4NCyp89jaW6UJA5IBomrRrN38mRE4I9XnDKk2c744ORgbEHiqDQeg67/ELyfv55H4ow
         Z3VB1+xp7+K7IWyqoFIuYjnakApXwmcRwwGSsYCtWJXa1CtO7LfUgjhzqG/akrLi77+0
         CFxWMVV8PjGaZHYC/AW77wm0kyg7QjKDo5dWzVZi/wKvsahzlj5YaIWlRTzZxxjAjehS
         9MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+1MxSbfv7IX5t2AzTeEksKn+lUCwLfRaz02Xo40oyE=;
        b=EpMx+p+ZXWvKfAHZ0eOKnPvNHeF9xF2O87cq8R8iOqNlo5h388iqUPhnhVON2CdROA
         8rUvHQ3hzzqtAXgPtXYLY6XCYBwGK+H9mgNBMnVabZBEsYDYO5rhjjGWrA+rCDbmNinH
         zrsGQ8ZbvLc1I+B4Km0ccwMHloMHeRxzJuFpkDOTK4vQC0c/2qLtf8jfu7Mwj+nmdbx7
         ZmPOHU9vD1KmXQviWeCK2iHmSQN+OUQZRGoeqyWlGG+f+VIMAukE8UXiAcUV5FbXT5y4
         LHVdPRRuKTEat1K6de4nBVOBNZiHa5Xl8b2EN9I8sHJyV/o1baEdH0k03eqJTLN4M2CW
         Picw==
X-Gm-Message-State: ANhLgQ1EiObBZzTp1m80mMO3IkfLWfnjv4J3sqgHLfNWd/t3CjaFQyj8
        mIDsM0VdOXNJSFP13Vky+7WhJYW6h4UYNtAWi9w=
X-Google-Smtp-Source: ADFU+vux3cmevvyp3Hpykkw9DSzJJmwriNzOZxefLMDLkQatzRM/D6GITGC2ThhyDRsK87+j3UNYG3gUIqwIZ2AQq0E=
X-Received: by 2002:a17:906:5c43:: with SMTP id c3mr15622990ejr.3.1584909306102;
 Sun, 22 Mar 2020 13:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200318005029.GA8326@mail.rc.ru>
In-Reply-To: <20200318005029.GA8326@mail.rc.ru>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sun, 22 Mar 2020 13:34:54 -0700
Message-ID: <CAEdQ38GNWO05mu_TD3aydsy1T9gvgFL9L_hyzeD=vWzTGCNMXA@mail.gmail.com>
Subject: Re: [PATCH v2] alpha: fix nautilus PCI setup
To:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 5:50 PM Ivan Kokshaysky
<ink@jurassic.park.msu.ru> wrote:
>
> Example (hopefully reasonable) of the new "size_windows" flag usage.
>
> Fixes accidental breakage caused by commit f75b99d5a77d (PCI: Enforce
> bus address limits in resource allocation),
>
> Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> ---

For completeness:

Tested-by: Matt Turner <mattst88@gmail.com>

Thanks Ivan!
