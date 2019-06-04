Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 599CB3457C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfFDLdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 07:33:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41326 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfFDLdw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 07:33:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id 136so4642815lfa.8
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2019 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASxZDvczStvZaA0VBviKVlooZ7GlgEB3+byQR32kp/k=;
        b=Ev3E4Q5ds8kRtofMeEhlq0dH5P79FuXtW5dzhqiD1UCOjKrYEcvIzNK0DvGVKlL/gC
         5hnLEsHWJJ8tVkSakD+W6TtRImmxmO8RvgRqp9+T+XAXrUiuhxGaSb06RGJbhfp7dFLR
         raODvceKMuOyY7COUAYvuHPNApTFJVK8fj7kUzCoiK2JLVj9irK79hHIVJONadMBJMpi
         mlrUgWIiIQ75wXya4DwCE5fDsM2pfnf1Iy4GpN4V3VQ01xvQ/tUdNhP/uDMjGEYWAZH1
         k8ko+TaCwwEnUH8a0NLoFKH6w9Ue5Zn75Ec7eWCiNvPb2Jy1zeiH2QnqUJu7+Q2iUGi8
         QHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASxZDvczStvZaA0VBviKVlooZ7GlgEB3+byQR32kp/k=;
        b=AksoFtBW1Aq/3aePXQFuOYE/Ke+qs0yGP0Lcu4P2KLEMSdXPCB/E5rEagDLKpx+KQ2
         idJUOkbm/vNrsCXE6PcaHkEQ3rn6+gEsMqe/rLbky1LkRynmxHncvxepBlwB0uiOFgOK
         36Jx3diMaVc87ctV35hLLTptwdcsk8tWXJlWn5MGlWJqPB7kjUNZ7EHO6UvBfTN1uEVn
         nkGS7Ov620QvK8Rlgtn2hZdV1i6fwHGrhHYZ8kZxnUnqNwmvWmh98PaPWsWWLYr11nee
         lh/IpVH20YqJ/gyerFcqzGwqNgX5t/YehTXil4tyf408RVWZNZNN6QCiolEEG8yzWBAI
         8daw==
X-Gm-Message-State: APjAAAU57j1XVGUb117BrTYPKYtZsDwJ2ZnL8pOzvoBxd3giN8xJbEGW
        yRmdokDvSqTYR3BwpQEcrL11Fw==
X-Google-Smtp-Source: APXvYqy2ewn+TJ31z8SQ+T9aaETF2ZblqkKMNvIWZBN6vbRH3jSlLfBfGhfFImz0Cn/uFgotAnyJlg==
X-Received: by 2002:a19:f601:: with SMTP id x1mr16378550lfe.182.1559648030291;
        Tue, 04 Jun 2019 04:33:50 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id s19sm293564ljg.85.2019.06.04.04.33.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:33:49 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:33:47 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Qualcomm QCS404 PCIe support
Message-ID: <20190604113347.GA13029@centauri.ideon.se>
References: <20190529005710.23950-1-bjorn.andersson@linaro.org>
 <20190529163155.GA24655@redmoon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163155.GA24655@redmoon>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 29, 2019 at 05:31:55PM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 28, 2019 at 05:57:07PM -0700, Bjorn Andersson wrote:
> > This series adds support for the PCIe controller in the Qualcomm QCS404
> > platform.
> > 
> > Bjorn Andersson (3):
> >   PCI: qcom: Use clk_bulk API for 2.4.0 controllers
> >   dt-bindings: PCI: qcom: Add QCS404 to the binding
> >   PCI: qcom: Add QCS404 PCIe controller support
> > 
> >  .../devicetree/bindings/pci/qcom,pcie.txt     |  25 +++-
> >  drivers/pci/controller/dwc/pcie-qcom.c        | 113 ++++++++----------
> >  2 files changed, 75 insertions(+), 63 deletions(-)
> 
> Applied to pci/qcom for v5.3, thanks.
> 
> Lorenzo

Hello Lorenzo,

I don't see these patches in linux-next.

It appears that only Bjorn Helgaas tree is in linux-next, and not yours.

I think that it makes a lot of sense for patches to cook in linux-next
for as long a possible.

Perhaps you and Bjorn Helgaas could have a shared PCI git tree?
Or perhaps you could add your tree to linux-next?
..or some other solution :)


Kind regards,
Niklas
