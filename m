Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6A2B6699
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 15:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgKQOFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 09:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387536AbgKQOFG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 09:05:06 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27847216C4;
        Tue, 17 Nov 2020 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605621906;
        bh=ou4lNzmE+mlCXOlccxfOjoaKyQac9Ol4/hfMNkE4xnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pi1tcJU6p9wN4VDCnuWjONBkT450PiBvmmkFFZ6N9XEl/nw1qKQvVZOcdbk1BIyWk
         /SW1Tck1h9FrM4MEbGOVEfH4S9L7Uo3acscVcCJ6330AwCEwtwrvY5Be67F8eeL9Ze
         NpZ9NP0PdSS6QNg3K40ahPjuoL8+ioX7ApPuLcvc=
Received: by mail-ot1-f46.google.com with SMTP id z16so19467588otq.6;
        Tue, 17 Nov 2020 06:05:06 -0800 (PST)
X-Gm-Message-State: AOAM5336R7s94KZCiJ03j1anMnZIkktbldnH0+mp8RfvXWAf95uPYYmQ
        jj2MzXEu/OHs3v4U55UY5zfMC24keFBkm7CJK14=
X-Google-Smtp-Source: ABdhPJzW2LFO73etaKLA0oG0uVw6YYNzE/dUSZle4uwnTWfCT8zunsuUKFWvYi1ZYV5eTeAkog8B2q0sJhVRkHK3K0c=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr2808403otc.305.1605621905385;
 Tue, 17 Nov 2020 06:05:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 17 Nov 2020 15:04:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3TpnQmcWFkBJyi7CxdzgyyzxXzA3mokYvcem6yEh7Bdg@mail.gmail.com>
Message-ID: <CAK8P3a3TpnQmcWFkBJyi7CxdzgyyzxXzA3mokYvcem6yEh7Bdg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] misc: Add Add Synopsys DesignWare xData IP driver
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 13, 2020 at 11:37 PM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> This patch series adds a new driver called xData-pcie for the Synopsys
> DesignWare PCIe prototype.
>
> The driver configures and enables the Synopsys DesignWare PCIe traffic
> generator IP inside of prototype Endpoint which will generate upstream
> and downstream PCIe traffic. This allows to quickly test the PCIe link
> throughput speed and check is the prototype solution has some limitation
> or not.

I don't quite understand what this hardware is, based on your description.
Is this a specific piece of hardware that only serves as a traffic generator,
or a particular hardware feature of the DesignWare endpoint, or is it
software running on a SoC in endpoint mode while plugged into a Linux
system running this driver on the host?

Most importantly; Is there any relation between this driver and the driver
we have for the DesignWare PCIe endpoint itself?

My feeling is that this should be located more closely to drivers/pci/,
but that depends on what it actually does.

     Arnd
