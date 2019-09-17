Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9FB5561
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfIQSdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 14:33:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36543 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfIQSdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2019 14:33:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so3788613oih.3;
        Tue, 17 Sep 2019 11:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iReD5mJ0Uir23drUba5qv+wNUfTA9iGbAoW+oBdI4B0=;
        b=o9/Zc4F2rqwbH6Qfl/Avq/mVRqx5TsVm84vfOXooD1sXd1FunzsupyeZw3se5h/idl
         zBFPCySl/PI13QxUxPnLVINNrUZTvEyp4vQ5p9AQJk7Xkwl6wDh7wnXLuCZ8MBaXlfAj
         M9CDHLoqgg5+x7ZuyzHm9Q3WOrpMykK+5FIQOX1hTqW/VOmeV+UXSp2j9PMxciCKTRZA
         RppJCMe7II8+J601HALIawG3FSHgsLTHhvhDglLNJlbsO0XdrZuyRRyjZVt3K/PJ8Cvr
         sdHHNcdk1iqsGuTEJLCt6gcRyRSD+AQDK9x4da3LAsLoV0MENjY81acL6LR3bRr7W9Pd
         KnuA==
X-Gm-Message-State: APjAAAXyrUkUF2+3X5eaygek5p6+IXdL2KFBqcJPldHAmgpCyvc+NoIg
        LXxj6gwioRklnkZ21IOjxA==
X-Google-Smtp-Source: APXvYqxF73vwBXOpDaa7aqGMYHwP4mdbPwabeO3dt9jcjKYG/4N/9T5DLOW9zoNxvRUubgyYhF6OxQ==
X-Received: by 2002:a54:4392:: with SMTP id u18mr5037847oiv.103.1568745188498;
        Tue, 17 Sep 2019 11:33:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a4sm959095otp.72.2019.09.17.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:33:07 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:33:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dilip Kota <eswara.kota@linux.intel.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
Message-ID: <20190917183306.GA24684@bogus>
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
 <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com>
 <20190906091950.GJ2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906091950.GJ2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 12:19:50PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 05, 2019 at 10:31:29PM +0200, Martin Blumenstingl wrote:
> > On Wed, Sep 4, 2019 at 12:11 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
> 
> > > +  phy-names:
> > > +    const: pciephy
> > the most popular choice in Documentation/devicetree/bindings/pci/ is "pcie-phy"
> > if Rob is happy with "pciephy" (which is already part of two other
> > bindings) then I'm happy with "pciephy" as well
> 
> I'm not Rob, though I consider more practical to have a hyphenated variant.

*-names is kind of pointless when there is only one entry and 'foo' in 
the values of 'foo-names' is redundant.

Rob
