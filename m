Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70CB4463E1
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 14:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKENQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 09:16:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhKENQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Nov 2021 09:16:43 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636118043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/u7nlX+6ERlKO2c5VX5W4zDFoPxQ1St3+7wALdbJ/Y=;
        b=QJQLgPycTbOzwLhKth6ieU6SZ9aj1KWPZUbPkCyj9bKDoppTIWBVx2VzeC2UftVUM7bOSP
        zkSj1e/qnZFODR+mjmhwF7UGnOhokTME+NUzSLWYVm+2D4B0JJ2/1yfzb5LVZmbzK9wa6l
        a+nWpEj85KWleP8i5B6FXn8dd178sakkcGOX7yCUbT5JB+9B5TTVbBCuGFZufaE4vRGJ0u
        M5sWV+jgzMdiDuEvXAEsmY5IlPQT7hn+srkNyIrvGWpQx/zqdq//9E/KMzanNObj9fMTN7
        39TU4ZMUsRlCro1zLn8rsV1oN2FOArFwqQPx0eB1vu5yi/9EYjfjqzBac2+C6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636118043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/u7nlX+6ERlKO2c5VX5W4zDFoPxQ1St3+7wALdbJ/Y=;
        b=3SZlC2cLzI9gKkoFBgmiY65Z5k8/TYekVIUOncR4iRLvHpw2a7HAF4Peb5wuJvPYnSKvJp
        GnmnM3oK7DaNvmCA==
To:     Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH 0/2] PCI: MSI: Deal with devices lying about their
 masking capability
In-Reply-To: <20211104180130.3825416-1-maz@kernel.org>
References: <20211104180130.3825416-1-maz@kernel.org>
Date:   Fri, 05 Nov 2021 14:14:02 +0100
Message-ID: <87ilx64ued.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 04 2021 at 18:01, Marc Zyngier wrote:
> Rui reported[1] that his Nvidia ION system stopped working with 5.15,
> with the AHCI device failing to get any MSI. A rapid investigation
> revealed that although the device doesn't advertise MSI masking, it
> actually needs it. Quality hardware indeed.
>
> Anyway, the couple of patches below are an attempt at dealing with the
> issue in a more or less generic way.
>
> [1] https://lore.kernel.org/r/CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com
>
> Marc Zyngier (2):
>   PCI: MSI: Deal with devices lying about their MSI mask capability
>   PCI: Add MSI masking quirk for Nvidia ION AHCI
>
>  drivers/pci/msi.c    | 3 +++
>  drivers/pci/quirks.c | 6 ++++++
>  include/linux/pci.h  | 2 ++
>  3 files changed, 11 insertions(+)

Groan.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
