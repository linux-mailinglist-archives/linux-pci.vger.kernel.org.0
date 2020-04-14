Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9B81A8711
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404395AbgDNRJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:09:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39285 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgDNRJY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:09:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id 8so815261oiy.6;
        Tue, 14 Apr 2020 10:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6GJ3AI3nqkhpV6mfsR8kDX9B2CWOF1AIByyVHf144ds=;
        b=NQOlMCNRr7nnE/h2emiiWsfIjhSE00B7auzw9MIbRCixaPmcW1wkQNGy7FiPaGhp6d
         4klbQOwWY8fLCsBgydTXRAozmtTCmiZFeqzF8OZJszSU3GR7HxTZ4ojZpys5BZ7ldx52
         c99pkw49WngJTGkfUdNeOACdQayB0todfXMAjMsmSiebFsHvu2lyj3SX6F2zbJQNWD/t
         RGt6pUj6CNBSUXOOnzNdR3xS9fEE+51oQyWiS3gsvhlEGoiyUFxwfNd1/DmZS7Wa9g+b
         yZXG6wOZ8CT3EYz/SCGKdFfzECtEf/FBULXx+gZtDZezqqGNZjGYDsKtzHJXCmwLTY3j
         5w1Q==
X-Gm-Message-State: AGi0PubWcYhKrSq0TS/Gy/dBoL22jj0In4CO1mm61v/3Ix8xNm2zpmny
        iklIGUGOeu+S7tw/HFgijA==
X-Google-Smtp-Source: APiQypJ+8pp+wDaIr8XSFcj4sATVl9vURGhQwAf2B4IQpLxZQ5inN5N/BhUmIpOoVNMdHtdIXoPUsg==
X-Received: by 2002:a05:6808:b1a:: with SMTP id s26mr15372072oij.150.1586884162758;
        Tue, 14 Apr 2020 10:09:22 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u17sm5602219oiv.21.2020.04.14.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:09:22 -0700 (PDT)
Received: (nullmailer pid 14867 invoked by uid 1000);
        Tue, 14 Apr 2020 17:09:21 -0000
Date:   Tue, 14 Apr 2020 12:09:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCIe: qcom: add Force GEN1 support
Message-ID: <20200414170921.GB11622@bogus>
References: <20200402121148.1767-1-ansuelsmth@gmail.com>
 <20200402121148.1767-11-ansuelsmth@gmail.com>
 <8e0ada17-c858-59d2-8d5c-5129e7625f33@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0ada17-c858-59d2-8d5c-5129e7625f33@mm-sol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 03, 2020 at 12:01:01PM +0300, Stanimir Varbanov wrote:
> Hi Ansuel,
> 
> On 4/2/20 3:11 PM, Ansuel Smith wrote:
> > From: Sham Muthayyan <smuthayy@codeaurora.org>
> > 
> > Add Force GEN1 support needed in some ipq806x board
> > that needs to limit some pcie line to gen1 for some
> > hardware limitation.
> > This is set by the max-link-speed dts entry and needed
> > by some soc based on ipq806x. (for example Netgear R7800
> > router)
> > 
> > Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 8047ac7dc8c7..2212e9498b91 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  
> > +#include "../../pci.h"
> 
> This looks suspiciously (even ugly), but I saw that the other users of
> of_pci_get_max_link_speed is doing the same.
> 
> Bjorn H. : do you know why the prototype is there? Perhaps it must be in
> linux/of_pci.h.

No, because the function should not be used outside of drivers/pci/.

Rob
