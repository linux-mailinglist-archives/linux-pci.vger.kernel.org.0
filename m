Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC71C9CF5
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgEGVHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:07:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33847 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:07:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id c12so5515932oic.1;
        Thu, 07 May 2020 14:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9/DVS+dary5bcN5wwyGQLe4r2M44cjfHRGvR6cavOks=;
        b=NwEk+5LRPrR8gY60b+mbxZB/zAfRmakJC3m05NqiVduCPUfMzJS2rZJV+z41Ru3f6L
         TQ1WjKj2bjgMISCUewNEYMQim2GvbyNXNdf67hR8wzhV5GV3ga1yNwurTiaiWDKvpK6Y
         WzNE7YPjqhgpknH4FQdEXNicfu3YlbXWJUfGZo6MLLMfSMfPK7kbTTJclIxtWeSfS3FM
         kL9cM1CWZ7uSmt0cDhVMFcp73cJaUE3KzfRtlipCBebuH2wMrz8i0PsN7k9YGBRPKCdH
         bliBsmbxeRVXhWxAa+87xu35QZPMtgo7mddn/JeWBNntT2b6xkiluIOvljNbi05KaFCD
         rMGQ==
X-Gm-Message-State: AGi0PubPXrkSwQ8hzIySUVT7YISOKZNpsWHbLK3+n0AK1mVWiWdBF77e
        IY8i5DcE74CKYwRVAH585g==
X-Google-Smtp-Source: APiQypIBgpIqcuerq6AtzGUWximQsZ+IdSaqx8tmt01/OcNReArRLM+RM4D3CN2f1QAlzqb1M54l8A==
X-Received: by 2002:aca:ec51:: with SMTP id k78mr8258261oih.60.1588885635412;
        Thu, 07 May 2020 14:07:15 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 4sm1770225oog.3.2020.05.07.14.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:07:14 -0700 (PDT)
Received: (nullmailer pid 26846 invoked by uid 1000);
        Thu, 07 May 2020 21:07:13 -0000
Date:   Thu, 7 May 2020 16:07:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 02/12] PCI: aardvark: Don't blindly enable ASPM L0s
 and don't write to read-only register
Message-ID: <20200507210713.GA26756@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-3-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 10:06:15 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> Trying to change Link Status register does not have any effect as this
> is a read-only register. Trying to overwrite bits for Negotiated Link
> Width does not make sense.
> 
> In future proper change of link width can be done via Lane Count Select
> bits in PCIe Control 0 register.
> 
> Trying to unconditionally enable ASPM L0s via ASPM Control bits in Link
> Control register is wrong. There should be at least some detection if
> endpoint supports L0s as isn't mandatory.
> 
> Moreover ASPM Control bits in Link Control register are controlled by
> pcie/aspm.c code which sets it according to system ASPM settings,
> immediately after aardvark driver probes. So setting these bits by
> aardvark driver has no long running effect.
> 
> Remove code which touches ASPM L0s bits from this driver and let
> kernel's ASPM implementation to set ASPM state properly.
> 
> Some users are reporting issues that this code is problematic for some
> Intel wifi cards and removing it fixes them, see e.g.:
> https://bugzilla.kernel.org/show_bug.cgi?id=196339
> 
> If problems with Intel wifi cards occur even after this commit, then
> pcie/aspm.c code could be modified / hooked to not enable ASPM L0s state
> for affected problematic cards.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
