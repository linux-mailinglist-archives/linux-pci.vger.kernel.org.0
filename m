Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD25477393
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 14:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhLPNus convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 16 Dec 2021 08:50:48 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:49341 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbhLPNup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 08:50:45 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M8yPu-1mu1On3Sqc-0068yT; Thu, 16 Dec 2021 14:50:43 +0100
Received: by mail-wm1-f45.google.com with SMTP id p18so18935567wmq.5;
        Thu, 16 Dec 2021 05:50:43 -0800 (PST)
X-Gm-Message-State: AOAM530sNw3bTznSxlxdOI0VhrIfdsD1XyYijLOz1yP3mS2m/Vu6FI/T
        9heHIAuP3aEiYaMJlXWgGa6ZBUfm4EHyalehKx4=
X-Google-Smtp-Source: ABdhPJxCd/5MpFbOtsFJckUJOZrM9UCRFM6hiyz1bgYXaPUV/X3iHVLNzmr2Do1QRYr3DDtCk0coUfAVZdKdklRM2bE=
X-Received: by 2002:a7b:c448:: with SMTP id l8mr5023776wmi.173.1639662643472;
 Thu, 16 Dec 2021 05:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-6-sergio.paracuellos@gmail.com> <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
 <6ee31420-ef67-471e-a924-a0158b4a9428@www.fastmail.com>
In-Reply-To: <6ee31420-ef67-471e-a924-a0158b4a9428@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Dec 2021 14:50:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2i6eW8JunE_6h6OTCa51eHfPahQQhaGHGWePX+r4ybww@mail.gmail.com>
Message-ID: <CAK8P3a2i6eW8JunE_6h6OTCa51eHfPahQQhaGHGWePX+r4ybww@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] MIPS: implement architecture-specific 'pci_remap_iospace()'
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:80Pym4TEwciI8AFXL+DnTsQX0Q/Xoj13+3T+GeEtE7Z+QQKJQ72
 aAtfMrv/GmlJGVB/4HHezvqzEuWQAwqqpuphykCYCryJ3TZqZ8myyTdnEEOBJwz0Q+RcUOJ
 qXQyfa7SJgpAjnzUlvZAZbhUNpLfxDD+acqXCUOKSxWgg+knGUTuK97mbugMdcW3EW3JVDb
 hTX5Sg9xKxeN7kNbfQ/tA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cQlJAIfGIjU=:5/EWPlfnvfCXCShInG+yRd
 ByIY2MmV5ngpwFFRbIIZDXF6zjzp+skhgntbfTHIHdDERW/rPB2hZEfwxtuYURwUozI42bEqc
 ZL0MquQkpXWIrzMSUN0DQZ6WpfwvdKxmTyMTDnk2FYapFuIyK3pEEuVAsuMiaDC2AqzcX2Tt8
 xOVXzjv7nkuk2r7pdnnpH6slFYfIEZop5JuFcK0QRl4zA+jbLuf2nQ29ZgLfm+kppnx1cW6Oz
 BUNdeMdE22csk9GfvCJHv2QsmVpbfwRjVMIXH0W7DI+V+2dtkmmAgeAHsKRzPFpe1OlPAn+ck
 if3JACp0LafLuaw9IRRmBiY5qu29EQnZslS3uoDea3LZfLAkPXfUFMny3hbpTjFXIaVaeLN9L
 ZxENR/LboNdg6MAD9z0vmPfKnrS0hILS8RP0pQcd6/QGsRpbv7L4hK7zsBLTb8A0ez3OOvn9S
 FBK3pcyY750PIAEtNm28WsRMOdNo7UlGbCYse7ZxQ5b9mf+pe7JQszaUJ+a+T0HN6cmvq/maa
 SY9tQOHfAnaNSrJMCH/2W+EP7CcMBThPMizko99nPFni4tz1r0pj/UctxigkkmCEDdv5nqppP
 inS5ZcHMas4MR4Is0HhjP1c3fVJxFzTGK90Y5phEpZ8dXR8FA/UKWaZua+9pfWqzCxUL2y7z5
 iaiMoSdeq7L+OjHy+q4YJGOIZkB3Yjr4hfQPoHXmy+sF8jfu3IUtn2+47D9kkg5FabYR9WF8V
 xnOoEY7M8QD5YH8UB5zfLMNmHCjpEyz58eYbZvTKyKgFmiZFKX4fSCo0Kd2oaw8Vwf/D2L5iN
 vb0/JCIicQIi/hA3kjVIaSH7996xjBClFT/MAZTQzAwCfz6CYM=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 16, 2021 at 2:07 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 在2021年12月16日十二月 上午11:44，Xi Ruoyao写道：

> Another way could be keeping a linked list about PIO->PHYS mapping instead of using the single io_port_base variable.

I think that would add a lot of complexity that isn't needed here. Not
sure if all MIPS CPUs
can do it, but the approach used on Arm is what fits in best with the
PCI drivers, these
reserve a virtual address range for the ports, and ioremap the
physical addresses into
the PIO range according to the mapping.

For the loongson case specifically, that's not even needed though, as
the two buses
have physically contiguous I/O port ranges, the code just needs to
detect this special
case.

        Arnd
