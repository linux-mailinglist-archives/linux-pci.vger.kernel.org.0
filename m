Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7483321C126
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 02:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgGKA2s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 20:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgGKA2s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 20:28:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F00C08C5DC;
        Fri, 10 Jul 2020 17:28:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id a32so5906416qtb.5;
        Fri, 10 Jul 2020 17:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xIJisSbZBmOeLheN8iotDynmIqVO/bf7e13TAsaCiaQ=;
        b=rn6fA+Z76JczMvWzzPokCnq0gjehoFVn3RERXre3NEVcgsf2bU0pLizKx4HTIocwoc
         jrMEYYssZmDzRR9B+B6BqNjTnd0vG5Teq7qYNIZO5XBLdmqQu6lM9B5fS2zQOJTbtziF
         7ojEOzkUO31uSsvIo6njztrdXImBC3iJjZEOPjp1kOfxn9/BHgTUf17RITcd0XR+y2W+
         rLFg/ONZ7tSxlfUzqTdivA7qJTYKs6I0SI5OVybqCNYIypZAXpIrQj9fDLmQ/TKpykn3
         RWMSKns8NSvSzS2DvGAqAKSt2GlsgMbGU4p1Wjvo1yvGylP85Vf1+M6XDq8KnPJrTvc/
         LLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xIJisSbZBmOeLheN8iotDynmIqVO/bf7e13TAsaCiaQ=;
        b=NK44TZDsDSjjkV7IdCiuFcecpu9jaqbJfRamrIdengXU0wypXKHkY0JOe/viV5i6lF
         bc/YKbtc8jYpmgVtipkXPr/XXRUD4/AS3TsX44cDi6DBvsVPFIkEXbcRS8YesESPbyw/
         S8UHUz9sungAOu0j8ESDU/wUe1enpHKw4R6piqb36lbhHADMEnXCQO9uV8ch0azdL6sc
         E7CB7Bry27wAGEMVU+nFWt/jw8Krb1MN8cf/05F4WZ5VRQ8Y2ziGpdqphQq6GwfpHCoi
         qp0tkDOO9plB07rpUn8BDun5GFkgphIhOX9Y9FLEK5hr++bXKobpTr1hrUvW1pcIelQf
         W81w==
X-Gm-Message-State: AOAM530mWeD5S9FFVlIoI9/Dk+B679U38p6BlmTpAB4xPpKTTQ4JSTnl
        TseDme2hAqnYzWaU80FnWegWva0Jh4QZRHtZJ5LFxo+P
X-Google-Smtp-Source: ABdhPJwaOO9NmbRGInX/e3hfEprHwJg1B5thMk4kRS4jV3qGDBdgDie4uW0FHvg7ClNjPR9fCse+tWrF79BlNpIu/O4=
X-Received: by 2002:ac8:7b57:: with SMTP id m23mr52986303qtu.379.1594427326881;
 Fri, 10 Jul 2020 17:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <CADLC3L20DuXw8WbS=SApmu2m49mkxxWKZrMJS_GBHDX7Vh0TvQ@mail.gmail.com>
In-Reply-To: <CADLC3L20DuXw8WbS=SApmu2m49mkxxWKZrMJS_GBHDX7Vh0TvQ@mail.gmail.com>
From:   Robert Hancock <hancockrwd@gmail.com>
Date:   Fri, 10 Jul 2020 18:28:35 -0600
Message-ID: <CADLC3L2ZnGTQJ+fwCy42dpxhHLpAFzFkjMRG3ZS=z7R4WK08og@mail.gmail.com>
Subject: Re: 5.7 regression: Lots of PCIe AER errors and suspend failure
 without pcie=noaer
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 10, 2020 at 6:23 PM Robert Hancock <hancockrwd@gmail.com> wrote:
>
> Noticed a problem on my desktop with an Asus PRIME H270-PRO
> motherboard after Fedora 32 upgraded to the 5.7 kernel (now on 5.7.8):
> periodically there are PCIe AER errors getting spewed in dmesg that
> weren't happening before, and this also seems to causes suspend to
> fail - the system just wakes back up again right away, I am assuming
> due to some AER errors interrupting the process. 5.6 kernels didn't
> have this problem. Setting "pcie=noaer" on the kernel command line
> works around the issue, but I'm not sure what would have changed to
> trigger this to occur?

Correction: the workaround option is "pci=noaer".
