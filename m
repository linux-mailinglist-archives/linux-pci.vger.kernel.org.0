Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91C745D5B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 15:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfFNNC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 09:02:28 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:36134 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfFNNC2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 09:02:28 -0400
Received: by mail-lf1-f54.google.com with SMTP id q26so1696913lfc.3;
        Fri, 14 Jun 2019 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNCCekNXxF72Z55DYxpSmTTnL0h6yytISWpjYq2m+S8=;
        b=Vo96BzDQ74ypjJAU1MqhEcnRuUOs8FJSEkzLVURbhq0pZauL6Hsk4zntSTKsxlRAwo
         6j3bgM0L61jhronOfeoLgFKzZpGbManW0X2Pf+OARHNkI0imiMTgoNLdd00bm0mQeQpA
         oU3M05EiGcaO+lfh/leIPWtJRx2wm4ATGCbhl6VEVR+B1hTLssf6ZHyqkijzOKmmgJLf
         T58p0FTsl5UC74a97uaWUPtTjq7YveSFTJavgTYAsz8Pwa+wNM7WhbWCnW0JrBA6tZK4
         ROw7OObTvdUeRJfGkDcN7PKDZOTo9o2mBXM5pj9nauJFNgwxgHW9Ym9g63T/FUUaZ9As
         7VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNCCekNXxF72Z55DYxpSmTTnL0h6yytISWpjYq2m+S8=;
        b=CXUDSf3c1H9PfnEjSFByApgCC1RtjkVbgLxFpLs8MKYIFiq/SpAmiyk9sBWOKvFj0b
         9Khrudhfcj3G3beWwFzhwT0+UXiSObIUpBP8uDQtnPaTxnPJjxQ7uOptl1MW5XBG0+vc
         Dn8hXjC4CPn0meynqyc5RfC7+bLvqvMMlbiqntSz1PrBSUfiq9q7GNvR0A6lXnmacIlG
         rmZxu+DFCbR3iYphLdxbjDieMqN3JOgaZhCxzXj9kFy6gDYFvqGREd9dGqRIjEbb3sjM
         xvuIwPmGyWE4HapRUxW5mtXKlUmsVoqdR6DeScmBLcRjccLYl9CACbxvHwfHsKGmzTKN
         qj+w==
X-Gm-Message-State: APjAAAU970eV7oRLDMyPbC8IoLh0NMZaPp/oHM6gQplci0/B4g5E8Kmx
        dGrcbPFwm5USwaHJs49P6q6872GzufYDr0C4G3oJIYgXxeQ=
X-Google-Smtp-Source: APXvYqzT19zAyV7NHT8SynOcQ+B8M0VI3VgBKEvgbGYpbH+azt1LL7LzIBctjZRJqLUl4EH9EsxvJr/pB4zAVN1SpBI=
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr5218050lfn.12.1560517345808;
 Fri, 14 Jun 2019 06:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <f297c15c-af4f-e4b3-feac-ca313f46f13e@sedsystems.ca>
 <74703679-96d4-b759-a332-c3f3bff9a7c7@sedsystems.ca> <CAOMZO5C9fu_h5Ct-rbSuTQ149JFT6tH-iN_r8dnYaDxE7gL+UQ@mail.gmail.com>
 <857036e0-769b-11bd-2083-5451670bd645@sedsystems.ca>
In-Reply-To: <857036e0-769b-11bd-2083-5451670bd645@sedsystems.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 14 Jun 2019 10:02:29 -0300
Message-ID: <CAOMZO5A+X_+4b3qGzSx0DzrU6UkH-KZ1Kd_WVNXP9pXXqFqFSQ@mail.gmail.com>
Subject: Re: iMX6 5.2-rc3 boot failure due to "PCI: imx6: Allow asynchronous probing"
To:     Robert Hancock <hancock@sedsystems.ca>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robert,

On Tue, Jun 11, 2019 at 8:05 PM Robert Hancock <hancock@sedsystems.ca> wrote:

> Based on some tests, it appears that may help - however it is hard to be
> conclusive since the behavior is somewhat random, it doesn't fail every
> time. The first few times I booted this version, I didn't see the
> problem, but after that it was consistently happening every time until I
> reverted the patch.

Do you see the failure if you apply this patch from Robin?
https://www.spinics.net/lists/arm-kernel/msg734813.html
