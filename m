Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5DD183CBC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 23:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgCLWpc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 18:45:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42551 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLWpc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 18:45:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so8356082ljp.9
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2020 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ZeV6SGwYz2oD3/6K0sLROfW8IF3ilKt8DtskElDrSY=;
        b=oiPs69xdfQO1PidLik8ECa+vZDnXjhz4IA9cfdIrSFWeQSVkq3f6Vuqtg7nqOSGpzz
         aPWaBfMxN76W6k+YcI62A04x9LTXaoGqfRVdTioZMtxmFIZ2XX/m9C8hi/X99aUXJ914
         9ZtRAdysFJjEsfngds8YFemQQIhGyWn7G4Y+IJL3vZL9RHKV9oZAdCdRXkqabn6itURW
         KehVOuHkxHYZ9iwT8WXYqXYA8GHnZmhc1a05rnJWy6NO2Zi4yA063X/yFhLO6pNOpfVR
         Nonz5KsXWFXaNuIPo/oM14mD6mg9ict9ghMTx/DvkJzdTyQWtVsc+S8eNXdCJTm1ZqhJ
         Kd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ZeV6SGwYz2oD3/6K0sLROfW8IF3ilKt8DtskElDrSY=;
        b=YlYYmYxzhXHTia9pHqhrHFPIMEo27PLu/xTflwK6L5haDk0Hanc2dyn3rjHBvku/7C
         rP32Wal0FOAX3zDFX4NI1EukBuM6NdrYC8QmgDE/b+PFUciV4ZbIgIWHvEzq2FSCT/qI
         NgdV+ftWiAZHtVcJzrk4JzpFarX5HJxz1yrvH6X+5727TauU+Py7AT3AJRbCbuHpm6v4
         0qRV1GK0PgH9gBlwrIsRcITiH2hmBvsCTuI47wsv7CAoq8EMQkqNwXspEGtO31gN5B5K
         mtZFCOpoVOewUHPqedWIRUErwztWZ1w2k5ADnJN35rUekoc1/yLM5FBRWiVaQbrBw8So
         ZjFg==
X-Gm-Message-State: ANhLgQ2yOod4+RbcrNQmklQRvy71ifAFj10H9xI22EbpizgIdxUCEuc3
        sC9i04OblDYe+tZPr0qil11TsQemys9H7IqXXhXArA==
X-Google-Smtp-Source: ADFU+vtWfdH9h+8ouBw1URtkmc7DSWqDje0HNsyXDSW5sqzgoSdTiC3LGQo1g/WEOkxlBaUBFPb4j6lbqK8aPWb9ouk=
X-Received: by 2002:a2e:894d:: with SMTP id b13mr5954798ljk.99.1584053130191;
 Thu, 12 Mar 2020 15:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdYv0U0RmT7snp+UejEXecq4wLkhc11DUniUfGYAgyXC=A@mail.gmail.com>
 <20200312190202.GA110276@google.com>
In-Reply-To: <20200312190202.GA110276@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 23:45:21 +0100
Message-ID: <CACRpkdZrSHTry1fmFbrAAwbVu_zi1oez-uD5-8RtOVL_H54O+w@mail.gmail.com>
Subject: Re: [PATCH 1/5] pci: handled return value of platform_get_irq correctly
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Aman Sharma <amanharitsh123@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 8:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> IIUC, in the link you mentioned, Linus T says that "dev->irq == 0"
> means we don't have a valid IRQ.  I think that makes sense, but I'm
> not sure it follows that 0 must be a sensical return value for
> platform_get_irq().  It seems to me that platform_get_irq() ought to
> return either a valid IRQ or an error, and the convention for errors
> is a negative errno.

OK I see your point.

I would be fine of the code is changed from:

if (irq <= 0)
  error;

To:

if (irq < 0)
   error retrieving IRQ

if (!irq)
   error driver requires a valid IRQ

To the driver (this one in specific) the IRQ is expected and
necessary and I think it holds for most PCI hosts.

Yours,
Linus Walleij
