Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C075742A362
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 13:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhJLLgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 07:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232665AbhJLLga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 07:36:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FB6610C9;
        Tue, 12 Oct 2021 11:34:29 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1maG37-00GEtZ-Nf; Tue, 12 Oct 2021 12:34:25 +0100
Date:   Tue, 12 Oct 2021 12:34:25 +0100
Message-ID: <87fst6pjcu.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Josef Johansson <josef@oderland.se>
Cc:     tglx@linutronix.de, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: Re: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
In-Reply-To: <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se>
References: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
        <b023adf9-e21c-59ac-de49-57915c8cede8@oderland.se>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: josef@oderland.se, tglx@linutronix.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rsalvaterra@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Oct 2021 19:47:21 +0100,
Josef Johansson <josef@oderland.se> wrote:
>
> I've got a late regression to this commit as well, but in the GPU area.
> The problem arises when booting it as XEN dom0.

What is the behaviour without Xen? We have some special treatment for
Xen PV which may or may not have an influence on the behaviour...

	M.

-- 
Without deviation from the norm, progress is not possible.
