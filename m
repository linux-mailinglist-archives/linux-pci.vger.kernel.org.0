Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBF1441AC1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 12:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhKALjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhKALje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 07:39:34 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC015C061714;
        Mon,  1 Nov 2021 04:37:01 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id v20so31205528uaj.9;
        Mon, 01 Nov 2021 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDdooqyDx/vbqdjlqxnv5zep/9eYPqzx8TDuAzZkEfk=;
        b=LWfMhe5seFG59hznRES6hX2VoQKXN6jBn3yaUo5Kq4ZXzOu3dSXUiksnfcRWbq1RA4
         005C6/6pWWPiHL2bVha5Ht4ckdrTsWFrJ++GjxQ5PxuvTGXI0MI7zVUKyRN+4Hb7kpqN
         oO2kR9TR6XQZ3rxHMusIxii/5XI/xNsA2phP92VNaRHpf9lbVorTNE7wbalg6WpmgwjA
         i4ViCrsMVrKfgZMSplwSZw3rC3QGhbKNf0XykX1hfUDqzB64Lkbp8DGl9e5AwmgSEDs8
         fHtPtET984R3JV2PNev6Gfw0Cfph7/UiBhkshag3JCBPB1qqsLI8VB/0pXtsdy11ah1b
         KKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDdooqyDx/vbqdjlqxnv5zep/9eYPqzx8TDuAzZkEfk=;
        b=bFaw3lVb0dpFmcIfJA7BuscOK7g19oKl5Wbn2EdY3883nB6oW7GHqc+o/2QjlgN1B9
         N4B7n5czAyuAtsW7C5gBgq6V0pBwhuHtN7UUycf2kqkRdYQnDS8nQFA0sJTazsDbfn1z
         aABzAdCb9D/x7jvlS7AXBcfoBOyQeuPCwQh3xuIbjoOYwaQbOC4wyqfcsy/G3yBEGtZN
         6rVb+Lo2TierSv6jKccwE5f1eVUU39ESmmwed8doKa1huZxy7pnWdoZ+0Keju2V7Wyrx
         bjEkYMOzVhCzpic/FacDNeO0f1upqQ7wdF0e2DDAg4gZaaXT1SIY/Vvd6xAfsSjjzwEJ
         L4tQ==
X-Gm-Message-State: AOAM530rmD1Gxi5d/hrqPwwSupr/jwOg7jPjea2KDHyzMA9ArTkT8cHR
        6qhYFgEedA6aZSO8zOw50RmUOlp2ED8zNDXSTg==
X-Google-Smtp-Source: ABdhPJwC/tA5100jIWnO3cX+1MkzDyJ0/4lMdOh2c3/2Kx3+edrW7QyPmLFllEW2HfpmWcGAcYsTqq9lhrX7gG83Gag=
X-Received: by 2002:a05:6102:941:: with SMTP id a1mr6023311vsi.0.1635766620619;
 Mon, 01 Nov 2021 04:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
 <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se> <87fst6pjcu.wl-maz@kernel.org>
 <ae50cd31-6b5d-3dc4-4ba7-d628a74dc722@oderland.se> <CALjTZvaE-u0cGRdDD=m8iXCMZvM65v_8wBQq3-vPN0+_3SgU0g@mail.gmail.com>
 <877dds9l4q.wl-maz@kernel.org>
In-Reply-To: <877dds9l4q.wl-maz@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 1 Nov 2021 11:36:49 +0000
Message-ID: <CALjTZvbYQ68aiYvukmh2uhvSCtdBVC03xxko8yji=SByaLBfOA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     Marc Zyngier <maz@kernel.org>
Cc:     Josef Johansson <josef@oderland.se>, tglx@linutronix.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Marc,

On Mon, 1 Nov 2021 at 11:21, Marc Zyngier <maz@kernel.org> wrote:
>
> Just being preempted with slightly higher priority stuff. I'll try to
> post the patches formally this week. I'm still a bit surprised that
> nobody else has reported such issue though.

No problem, I was just worried it could have fallen through the
cracks. As for nobody else reporting it, I'm inclined to believe the
combination of building/running bleeding edge kernels on Atom 330
systems from 2009 isn't exactly common.

Thanks,
Rui
