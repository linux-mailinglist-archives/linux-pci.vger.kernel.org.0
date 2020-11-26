Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF82C5E4A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Nov 2020 00:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbgKZXqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 18:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgKZXqC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 18:46:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B993AC0613D4;
        Thu, 26 Nov 2020 15:46:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606434359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jm3trDZs2718Nq5qmyX6yF17hhp4QM/wTJbnNLUJFxM=;
        b=iZi1qo83o5fs+vlu4+dekBXqIV8GFGw7W/dxJXPxjlj8pJbInC3lHg44oYBn4uF8lQegya
        XEnbgxLmQcBDq25U6kmKG+svIACh4OdheTYNY7zq6PnSgYvCz13lloj8xIhk+0oHD24BTG
        oqzucwF40KrXG8F6fEMG250XrKzEONUnl7l6ecvxV/6NXQ2es2nKydtlKnDBpETYYVGI+M
        v7Zp8dbvogMn7AES0KszTsLHC13i/oFpOuA6joxchtavJH7hfGgoFVMj29Ase2nXpuOEfs
        oBVqWW1/zLyqxCujAPWlEn00+njmCPvMRHylWtNCNmigolvRPl7tVhIw05Qogg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606434359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jm3trDZs2718Nq5qmyX6yF17hhp4QM/wTJbnNLUJFxM=;
        b=py+qfo2WlcnagPSLxEU+AK7kCxekA8q6QytsGP4WVywQr+Sk4nJZJ7lHNK4tVBBq3kzISq
        eLF7TLoc/rRGikDQ==
To:     Stefan =?utf-8?Q?B=C3=BChler?= 
        <stefan.buehler@tik.uni-stuttgart.de>,
        sean.v.kelley@linux.intel.com
Cc:     bhelgaas@google.com, bp@alien8.de, corbet@lwn.net,
        kar.hin.ong@ni.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mingo@redhat.com, sassmann@kpanic.de, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: boot interrupt quirk (also in 4.19.y) breaks serial ports (was: [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
In-Reply-To: <d512469f-de04-2f66-ca42-21ec3c5331ba@tik.uni-stuttgart.de>
References: <20200220192930.64820-1-sean.v.kelley@linux.intel.com> <b2da25c8-121a-b241-c028-68e49bab0081@tik.uni-stuttgart.de> <87zh35k5xa.fsf@nanos.tec.linutronix.de> <d512469f-de04-2f66-ca42-21ec3c5331ba@tik.uni-stuttgart.de>
Date:   Fri, 27 Nov 2020 00:45:59 +0100
Message-ID: <87blfjk7go.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Stefan,

On Wed, Nov 25 2020 at 14:41, Stefan B=C3=BChler wrote:
> On 11/25/20 12:54 PM, Thomas Gleixner wrote:
>> On Wed, Sep 16 2020 at 12:12, Stefan B=C3=BChler wrote:
>> Can you please provide the output of:
>>=20
>>  for ID in 05:00.0 06:00.0 06:00.1 06:01.0 06:01.1; do lspci -s $ID -vvv=
; done
>
> See attachment.
>
> Also I boot the affected systems now with "pci=3Dnoioapicquirk", which
> "solves" the issue too (instead of patching the kernel).

Yes, it skips the quirks.

> 05:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-P=
CI Bridge (rev aa) (prog-if 00 [Normal decode])
> 	Physical Slot: 1
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 32 bytes
> 	Interrupt: pin A routed to IRQ 16
> 	NUMA node: 0
> 	Bus: primary=3D05, secondary=3D06, subordinate=3D06, sec-latency=3D64
> 	I/O behind bridge: 0000e000-0000efff
> 	Memory behind bridge: fb400000-fb4fffff
> 	Prefetchable memory behind bridge: fff00000-000fffff
> 	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>

Can you please run this as root so the Capabilities are accessible?

Thanks,

        tglx
