Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B263130D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 18:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEaQwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 12:52:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34332 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfEaQwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 12:52:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so10305564ljg.1
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2019 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6H5MAo72kBrswxB03BJ2HpgepSBZLZhL5ogd8zupLU=;
        b=OG1KV6FZLFhvOSN7fp5zLXlrz323yy7uJi4Is23x/8ff/t7fSs6pfOXJAFwM3v/wC6
         b9K7GkitQpHZawyKE3kZzpHbUuUtubBxLFGtKQ2iRJuiB3CI/MtfFoiCW29iMCQ8dHlN
         QW4ksaLmQ68g1benk9nLF3YHPQ85XFEH5RDoUn+xKSZoOZtOcUIY2YJIT/2lrQR9EcJX
         bNwq2XPMP9F+dNHBk8DrarZ3IP1HCvYQ4wsw6VYNZrPGenSK8cfmfLXlkbFLnLqByxJP
         OENBIcoFg7Xni3OlGtxAWkC4nxDOrxtqSZecSg+B09IXvXCPXiIzA7QrmluirCajIzO0
         LhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6H5MAo72kBrswxB03BJ2HpgepSBZLZhL5ogd8zupLU=;
        b=FdBkhqKI7s9GpuwIrjQA1SLuopyX8K76jpYv0LWnJI2YhQLH4cVDHqp8bohPwMXMGp
         NvvmwBJ2D2XyUwV/M1CdW/jO/6mC/L4P0XiXyZUkMcfvPOsvHlcyQ2Z//Pfduq4zaHit
         qzvLn01Aurx9ddHEKJ68O9OqrBKHAkM76Bh9yZeLvY0/uZ5i1XBY2Hg3e1JPLlGa4e7n
         QeAeGauy299rwGD62XvMgFVf1Emo3egj/L8N/JQm/RUgo3L1AP5V3XNaWC5ottds8pXI
         2iBmQbF+CSafJtDFhEU72PFz1Z63U4KyDzrtyeWDs2qyvGTpK78M//07Ey826dHM/wPI
         qqPA==
X-Gm-Message-State: APjAAAVrxLLXdFTxgPtqqKhy6YmHj0rHtKkDJToxHTePGJS6F8Ps8Sme
        QeT9sdx7fQD+lCIciUWxfnWaaBAOtUC8goqRIsGiyQ==
X-Google-Smtp-Source: APXvYqx+7FWVD3TK8yBjAqQZMlMkuV+lN5tCxVL10+M37w8cNW4yMIcMcmxP3Kt1PI37oQbyVpTXf/64SZ+48DwdR9o=
X-Received: by 2002:a2e:864e:: with SMTP id i14mr6485594ljj.141.1559321562622;
 Fri, 31 May 2019 09:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <1558648540-14239-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGzHkt4p_byEihOAs9g97t450h9-Z0Qu2b2-O1pxCNPX+A@mail.gmail.com>
 <baa68439-f703-a453-34a2-24387bb9112d@ti.com> <CABEDWGyJpfX=DzBgXAGwu29rEwmY3s_P9QPC0eJOJ3KBysRWtA@mail.gmail.com>
 <96365941-512b-dfb2-05b7-0780e8961f6c@ti.com>
In-Reply-To: <96365941-512b-dfb2-05b7-0780e8961f6c@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Fri, 31 May 2019 09:52:31 -0700
Message-ID: <CABEDWGyQHh=8fmZFAK6acecDSF_-pfpa9NCZOQ--WDhZiZPihw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: endpoint: Skip odd BAR when skipping 64bit BAR
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        wen.yang99@zte.com.cn, kjlu@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 30, 2019 at 9:37 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Alan,
>
> On 25/05/19 12:20 AM, Alan Mikhak wrote:
> > Hi Kishon,
> >
> > Yes. This change is still applicable even when the platform specifies
> > that it only supports 64-bit BARs by setting the bar_fixed_64bit
> > member of epc_features.
> >
> > The issue being fixed is this: If the 'continue' statement is executed
> > within the loop, the loop index 'bar' needs to advanced by two, not
> > one, when the BAR is 64-bit. Otherwise the next loop iteration will be
> > on an odd BAR which doesn't exist.
>
> IIUC you are fixing the case where the BAR is "reserved" (specified in
> epc_features) and is also a 64-bit BAR?

Correct. If BAR0 is specified in epc_features as reserved and also
64-bit, the loop would skip BAR0 by executing the 'continue'
statement. In this scenario, BAR1 doesn't exist since the 64-bit BAR0
spans the two 32-bit BAR0 and BAR1. The loop index 'bar' would be
advanced by 2 in this case so on the next iteration the loop would
process BAR2.

> If 2 consecutive BARs are marked as reserved in reserved_bar of epc_features,
> the result should be the same right?

If both BAR0 and BAR2 are reserved and also 64-bit, the loop would
check BAR0 on its first iteration and skip BAR0 and BAR1, check BAR2
on its second iteration and skip BAR2 and BAR3, then check BAR4 on its
third iteration. If BAR4 is also 64-bit and reserved, the loop would
skip BAR4 and BAR5 and that would be the final iteration of the loop.

Regards,
Alan
