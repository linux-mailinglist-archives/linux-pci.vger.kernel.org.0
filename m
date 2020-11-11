Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C201B2AF4C7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgKKPeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 10:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKKPeX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 10:34:23 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C4F2074B
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605108863;
        bh=EEJxUW6yBqL1lIySKM25rp6jvV/z7A66T3aGJ2g29SU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gxZOxzwEayji50MiEM0ROnPLxwpLkXHiNiJjN++gg6qRyWnZw3cDIGDLf286p02EU
         wJ6KXKo6qfFcJ508NsgyXP5l2fSFAFw3Ey1Bh4rHPNzT9tc+wE7MwgWnAl5NFjGVSK
         CckIWllrMAJoh86qjRABpjXgseYdib9fP75RQHqk=
Received: by mail-oi1-f181.google.com with SMTP id u127so2592615oib.6
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 07:34:22 -0800 (PST)
X-Gm-Message-State: AOAM533LiL56LLT5miat7zJRWkUoWHUW2+hHFWVcX3VhCgN292FnHRgs
        r1FpCz9YipnCanxbKMz8QPCU1IgX3aC6+q896w==
X-Google-Smtp-Source: ABdhPJwHbWkG/EXSCatCXbAkd6vgiZ2vjCqn/ERtEzb1kzv+bNfoZKBCyUdfoCP4XO+7PUhiQ0gOx+1xi0wWRhVDMYc=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr2511412oib.106.1605108861919;
 Wed, 11 Nov 2020 07:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20201110171641.GA679781@bjorn-Precision-5520> <DM5PR12MB183506CDEA67A7A65B0F1F29DAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB183506CDEA67A7A65B0F1F29DAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Nov 2020 09:34:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4qVTyUGr3Stn2GaoaYpTJRhSTMw2KKdjVS1+H=uPVWA@mail.gmail.com>
Message-ID: <CAL_JsqJ4qVTyUGr3Stn2GaoaYpTJRhSTMw2KKdjVS1+H=uPVWA@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Linux
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 5:36 PM Gustavo Pimentel
<Gustavo.Pimentel@synopsys.com> wrote:
>
> On Tue, Nov 10, 2020 at 17:16:41, Bjorn Helgaas <helgaas@kernel.org>
> wrote:
>
> > New Coverity complaint about v5.10-rc3, resulting from 9fff3256f93d
> > ("PCI: dwc: Restore ATU memory resource setup to use last entry").
> >
> > I didn't try to figure out if this is real or a false positive, so
> > just FYI.
> >
> > ----- Forwarded message from scan-admin@coverity.com -----
> >
> > Date: Mon, 09 Nov 2020 11:13:37 +0000 (UTC)
> > From: scan-admin@coverity.com
> > To: bjorn@helgaas.com
> > Subject: New Defects reported by Coverity Scan for Linux
> > Message-ID: <5fa924618fb3b_a62932acac7322f5033088@prd-scan-dashboard-0.mail>
> >
> >
> > ** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> > /drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_rc()
> >
> >
> > ________________________________________________________________________________________________________
> > *** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> > /drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_rc()
> > 590
> > 591                   /* Get last memory resource entry */
> > 592                   resource_list_for_each_entry(tmp, &pp->bridge->windows)
> > 593                           if (resource_type(tmp->res) == IORESOURCE_MEM)
>
> Can the pp->bridge->windows list be empty in a typical use case?

Only if the DT has missing/malformed 'ranges'. 'ranges' is required to
have any memory or i/o space, so we would error out before this point.

Rob
