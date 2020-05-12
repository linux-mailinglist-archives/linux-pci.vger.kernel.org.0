Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBE51CF98C
	for <lists+linux-pci@lfdr.de>; Tue, 12 May 2020 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgELPps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 11:45:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38605 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgELPps (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2020 11:45:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id m33so10871642otc.5;
        Tue, 12 May 2020 08:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjhqZR0KFtDODzXTbFPWHQLNPIl2BEjWfgjvJzwWtyM=;
        b=DXdivuamiPck6uKR1utxJP9eYvBK8zO8w62MapXJMpjeEK+/xSvnLLZhBJ1QwKMdOf
         VIjkP8q3P21ERM2InRTa580tE/HfLQwzi9jc22+fJ9jplwflr2EThPE1TJjfLvV4Imnf
         dBmSP/q5m8pCi1wYjrclErYqgeHfbp5YtJwKa/2CB7gaxIi82KuIn9wqnki2AaOX/qIp
         i+xaDUGNv6Dm1GEtMNrTLJE2X+6LJggN8rmAG43Upm91/5UFhERZNL2GEIfkvF138oea
         ipBpwKNnv7XPehFzFp6rO6UAc9F0lPjyz2cAs8myU81/0fOKmvx3hv8EwS0DCDnqlssx
         BLPA==
X-Gm-Message-State: AGi0PuZOJJzMthXFSrTcvXuRZe69ZE6RMh+LxermEnfFV2ix3Ql3EahY
        eWaqe/MCC10vjs//CHNdUg==
X-Google-Smtp-Source: APiQypL6/T/FPzkcOYcltEodmiZvU7X6jDCHWnt/PGwkj5Xv0c65PIVAc4kQx2qq4cpuP4NKW2EpCw==
X-Received: by 2002:a05:6830:1e25:: with SMTP id t5mr16362224otr.358.1589298347136;
        Tue, 12 May 2020 08:45:47 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d61sm3517309otb.58.2020.05.12.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:45:45 -0700 (PDT)
Received: (nullmailer pid 4011 invoked by uid 1000);
        Tue, 12 May 2020 15:45:44 -0000
Date:   Tue, 12 May 2020 10:45:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     ansuelsmth@gmail.com
Cc:     'Bjorn Andersson' <bjorn.andersson@linaro.org>,
        'Andy Gross' <agross@kernel.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Stanimir Varbanov' <svarbanov@mm-sol.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        'Andrew Murray' <amurray@thegoodpenguin.co.uk>,
        'Philipp Zabel' <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: R: [PATCH v3 08/11] devicetree: bindings: pci: document PARF
 params bindings
Message-ID: <20200512154544.GA823@bogus>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-9-ansuelsmth@gmail.com>
 <20200507181044.GA15159@bogus>
 <062301d624a6$8be610d0$a3b23270$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <062301d624a6$8be610d0$a3b23270$@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 09:34:35PM +0200, ansuelsmth@gmail.com wrote:
> > On Fri, May 01, 2020 at 12:06:15AM +0200, Ansuel Smith wrote:
> > > It is now supported the editing of Tx De-Emphasis, Tx Swing and
> > > Rx equalization params on ipq8064. Document this new optional params.
> > >
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../devicetree/bindings/pci/qcom,pcie.txt     | 36 +++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > > index 6efcef040741..8cc5aea8a1da 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> > > @@ -254,6 +254,42 @@
> > >  			- "perst-gpios"	PCIe endpoint reset signal line
> > >  			- "wake-gpios"	PCIe endpoint wake signal line
> > >
> > > +- qcom,tx-deemph-gen1:
> > > +	Usage: optional (available for ipq/apq8064)
> > > +	Value type: <u32>
> > > +	Definition: Gen1 De-emphasis value.
> > > +		    For ipq806x should be set to 24.
> > 
> > Unless these need to be tuned per board, then the compatible string for
> > ipq806x should imply all these settings.
> > 
> 
> It was requested by v2 to make this settings tunable. These don't change are
> all the same for every ipq806x SoC. The original implementation had this 
> value hardcoded for ipq806x. Should I restore this and drop this patch? 

Yes, please.

Rob
