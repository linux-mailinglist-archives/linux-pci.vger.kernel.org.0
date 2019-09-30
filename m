Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4034C293B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfI3WBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 18:01:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38308 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfI3WBM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 18:01:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so8238006lfc.5
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmCtOoNN+IAWQ9Fu28/tn+TumfgRjlSGKb0ukLkHfB8=;
        b=iue2Bq/gal7TgW5wPEwYaAYnajZSR+fEPp1OrCDDAzcq/ZmRxPAkKS8G4qmB+PCTji
         472OELfznm1aFvrGAeGi2rye/uvrIGPAwQaITT8N/OYOrAfZoyuxvj39DAzhZyYwZZNR
         JcPA1Rlt0vZARbKHjpMUcos+eQs+ydX0/x22K2gvGyplGK6bSKyTFx93lz52ljMNk2Qq
         Eu2zrXbwifuRkDC5xMr7/LAEY2HLBJeSLIUfg/3kMFs/EI0sGPWmRho/O0c9jSlPfiWx
         nAd5AXNEQYJ5hb4uzK7s4mD7UscrJFI3U2vDDAjdh4zOjQoWBrxRn9EnWJce4Lo8bbzf
         dCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmCtOoNN+IAWQ9Fu28/tn+TumfgRjlSGKb0ukLkHfB8=;
        b=obF2uDbyK/D07WcDLxrPqoqiHr6R6qSX+qORsRPyBinBobGlaBew7Swb937+q3NjHT
         zJKWQklMNA7Qav3ypfChv8VqfyezEpzN35c5Mwj47jeSsbxZh9eRrSXiTnpd6GCIK6zO
         PmnblQUl8q3r0NJfWcES5uzA6ueSvvCUmfMEh4GAjKqaKN3WTC6uoZyfqBYdHRSx2Yck
         U2E/41hu44DqBrOB3KMzSFFw+2GdtUIJyPpx4JRVGaXOFHy8dU5E+oDTyNR8JzYCxZ+J
         25qAgu/H2oI00lrbbU/hZLqwGiT3Lj1uQMf15vLW+XkWYE6pY49zROTR+L90dGfZdvUn
         mSOg==
X-Gm-Message-State: APjAAAXmh9O3T6H83JKlJIAOH4V/ISzacH29Q/MsvKoDAEy/QqDqEbFJ
        RuagI+wZUd2ZTbHfAGImTtlBUCAunE+/739D5SknW7uNPYY=
X-Google-Smtp-Source: APXvYqz1EOrXdaQxayeMgzrbvDcXECvkn7kcnZOmmF9vsQ+tO3ZYD04adPYwz0r6rhnFUruh3Iz+aKyhipoHdmyOOss=
X-Received: by 2002:a19:14f:: with SMTP id 76mr12322365lfb.92.1569880868945;
 Mon, 30 Sep 2019 15:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190924214630.12817-1-robh@kernel.org> <20190924214630.12817-9-robh@kernel.org>
In-Reply-To: <20190924214630.12817-9-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Oct 2019 00:00:57 +0200
Message-ID: <CACRpkdbLT5LsK+WX6ziggV0o24DWSy+kQmgodQBGbSrUWTSLdQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] PCI: v3-semi: Use inbound resources for setup
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 24, 2019 at 11:46 PM Rob Herring <robh@kernel.org> wrote:

> Now that the helpers provide the inbound resources in the host bridge
> 'dma_ranges' resource list, convert the v3-semi host bridge to use
> the resource list to setup the inbound addresses.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
