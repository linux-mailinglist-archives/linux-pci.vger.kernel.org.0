Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F462D3A17
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 09:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfJKHfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Oct 2019 03:35:36 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33639 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHfg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 03:35:36 -0400
Received: by mail-ot1-f45.google.com with SMTP id 60so7175445otu.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2019 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLevZQnhaybY5aKcyCqsco2461EVCw4qKyv644p7bBs=;
        b=HBFV7WQRWKwWdcxuQKc2Mjrj2x26784t2iZxF9ivnDGGVfGzf/j2LvlNLgk/mgH4Oi
         pF3WJwmPXPF6qYC1FHC2uIRrmz5EM9gO/DvCpFNhgFkqdKz1afWEiwIg6Q17Dknx9HUU
         AjkHEmm4E035PXH7uWxB4hbVXWou68DStvPerJJxSXiKb1pF6K11Kl1zqSPLUVF5h1Sh
         Nyq/sdY9mMOimm0K9oQZyd3vrAKQaNkcDffjjvqOSJxOPdRkYKfXeQXGn4ROfWZrVW9E
         5cemiNpItnQxCjexsf4cLLnj0RwHTiHbIJrzxqgid7o95aMJ4xY9vaJVv6atxRAAtyBj
         P/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLevZQnhaybY5aKcyCqsco2461EVCw4qKyv644p7bBs=;
        b=Lr7eRl48zXfY4YFCDbcVTNs7xukqj/amp0GXk/ythJKwzb3jU2lZjyUckyWR5qJjt6
         A85UqYMspN/RGc0jhhmFn0SN0j99J3mACXLayZ61zWId3et6V7rOY1V26IAAJ6dor+EN
         EzCDMSIeFpxS85720qHBrfyBvo1SKPE10b5KS6sXH+y1/jWqoSpAHYRj+50gmlYX6iYt
         6qKmMlvRGA0kd4dcPEK0kJG6AANedXYCHJIuoXkTM7tTeLtOtGdzZLiNob6EX+PuPDOO
         0x9zMmSD54rCZOEvtobzvplj8Qs+ogMZ/7O8Byy9FB9PACeDrN9o9Y16s4TxvMMmwE/Z
         laww==
X-Gm-Message-State: APjAAAUwXY40GaYwxfVoDLAp4+EoifL/PjRRaaVo6xcUyCzcaf7inO1E
        DSVcqpBQIuNu+AmIVLuYpF0h1S0NEGjoe9DLxTQ=
X-Google-Smtp-Source: APXvYqzaEWTpWqc4fI+8Y9FpJm5Ge8BSA/VURWUP6exKaGyBFvC/jbRnelyvaBpf7XzSEbIIRwMKOVosa+mdh7BI/gk=
X-Received: by 2002:a9d:3e4e:: with SMTP id h14mr11845447otg.198.1570779333554;
 Fri, 11 Oct 2019 00:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
 <b91c3f6e-cef5-c06d-4282-84c24d616533@ti.com>
In-Reply-To: <b91c3f6e-cef5-c06d-4282-84c24d616533@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 11 Oct 2019 08:35:07 +0100
Message-ID: <CA+V-a8tFB=giGvcLNhfTaaQ-R8svXijcoQ_QUdRMX3Hb4Ur95Q@mail.gmail.com>
Subject: Re: [Query] : PCIe - Endpoint Function
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Thu, Oct 10, 2019 at 12:32 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 10/10/19 4:57 PM, Lad, Prabhakar wrote:
> > Hello,
> >
> > I am currently working on adding pcie-endpoint support for a
> > controller, this controller doesn't support outbound- inbound address
> > translations, it has 1-1 mapping between the CPU and PCI addresses,
> > the current endpoint framework is based on  outbound-inbound
> > translations, what is the best approach to add this support, or is
> > there any WIP already for it ?
>
> How will the endpoint access host buffer without outbound ATU? I assume the PCI
> address reserved for endpoint is not the full 32-bit or 64-bit address space?
> In that case, the endpoint cannot directly access the host buffer (unless the
> host already knows the address space of the endpoint and gives the endpoint an
> address in its OB address space).
>
for the address translation to happen on the endpoint I have to
program the local cpu address prior to start of link,
Yes the host somehow has to know the address space of endpoint and
pass it to the endpoint.

Cheers,
--Prabhakar Lad
