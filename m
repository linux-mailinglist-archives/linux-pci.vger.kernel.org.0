Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E87944114B
	for <lists+linux-pci@lfdr.de>; Sun, 31 Oct 2021 23:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhJaWx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 18:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhJaWx4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Oct 2021 18:53:56 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9906C061714;
        Sun, 31 Oct 2021 15:51:23 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id az37so431138uab.13;
        Sun, 31 Oct 2021 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPFwVr5kk0vqZjJlI+7yEVQ4/r8h3+RsMnwNH7XHCsM=;
        b=Z4T+Z3vARLXA535mSg7xlLU+HWKaVfg594r5Dq5kpAbBdu8l/+Pt6nXuWIeLv1uEVs
         4vm/bx/Lv1Y3phpO632wFvT8GhpLFS2GJBfUhCAgZ1F0dNKI4/kkTEvAVJg0Xbzw9zng
         +ARDMyojIfbhYUSw/canZQEAPQwNKD1NiuaJYgzI5J8ZwUwlgZUZyk9dsTIo2Rak/TCb
         IsxgyK7HMtf+6VbWsdlue60gaEFB092l77v/GX06jcleYwpCcZJGPne5CmfnqzA6KDfp
         +Q0GzEUM7SZ3KPbR0WZ9xsnT4lrjF1G+fjUyTcSlBL/qe8A8k3IBQiGYcmesrHN13Eii
         1k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPFwVr5kk0vqZjJlI+7yEVQ4/r8h3+RsMnwNH7XHCsM=;
        b=vJAgl7kRx7iP5G9FbYLg2UhP8CBuP6Sc7EvysKlOkg2P4Ou8prH+ePhF1oR6DNRsRa
         BO+RpCAlud3edSRkrDjsTY/pZwbNdR6cKeLGqEvqx2OWRjZtkLsR/gPbr5NNyA66Qhh7
         eTAhNSh+SkUWQqDVp6kzWPYA+kEDGXJZZasL0H9rdE5hVU/D/DMzu6ATSl/g7fl4sb8Q
         xHkkPrZxRvxCC1nGadP1GX+vQ9ww5L/ISSBWejX7GATYN+XEX6J3qhZlkzJ5ygMMq6bO
         PynWhIqIs2Fd1B57YVWBAH7uGObJF/Bn7/lkJrntAMSY39TqptIFvssvDqqtzOQxmp8v
         IANA==
X-Gm-Message-State: AOAM533UEzgKpbtuIsmbCaAlC78zzXLlWHVWOwIbTnB8131lXUikKUZ7
        oE8y8KiP9/WRDmoYRG3U7UdwK0clFcQIadlH715AnQ0=
X-Google-Smtp-Source: ABdhPJxC+Ljs59vrx7a82ou1aFtq+enfXhEtw9OOVkKStyHZVDeYe9nq0nJEPBDjXZNVwKWw7HDKpXsm0VZ/ze93Ygk=
X-Received: by 2002:a05:6102:941:: with SMTP id a1mr4005440vsi.0.1635720682818;
 Sun, 31 Oct 2021 15:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se> <87fst6pjcu.wl-maz@kernel.org>
 <ae50cd31-6b5d-3dc4-4ba7-d628a74dc722@oderland.se>
In-Reply-To: <ae50cd31-6b5d-3dc4-4ba7-d628a74dc722@oderland.se>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Sun, 31 Oct 2021 22:51:11 +0000
Message-ID: <CALjTZvaE-u0cGRdDD=m8iXCMZvM65v_8wBQq3-vPN0+_3SgU0g@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Josef Johansson <josef@oderland.se>
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Marc,

Linux 5.15 has just been tagged, and this fix isn't included (I
personally don't mind, since I'm carrying it in my tree). Any specific
reason for it?

Thanks,
Rui
