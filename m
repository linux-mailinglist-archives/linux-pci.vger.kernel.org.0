Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3C1C9D24
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEGVU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:20:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35835 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:20:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id k110so5830470otc.2;
        Thu, 07 May 2020 14:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hOjqyqhOaIxUNnyywiIqTrJIfIxOb9jgce5mWbZFbEg=;
        b=Ft+UImIrFUK5VOaCCJanEyx2nrx/VEtfTz/3N5OfKGKLd9yNBqODNTv3G5qDPVdhto
         nJEsfkJwgjbTkQeYkN2rA/GQALH7wKr4OPlpdt3OY9TSVswQCk+H3DsYc4ciffzvoT4f
         /9H4IDEtSO8yXotCaCS6PL6duIwtKmTvujE4Gf+wFkyHSk473hfoGv+bpTdrVWRJB2AX
         eed0hY5TDsL0iNnd3j8goW5yXd7wYFYEldjBR1e/nVLvMrcB8w82vURdJrVURP0ChTVh
         LUn59nW5hb9YozFOJtEQv76IZTwb6un9z1l5QfDCOzT8QVAPkDrIzYAOKYi3/1lJuNMy
         zh/w==
X-Gm-Message-State: AGi0PuaVFQ3yW/gk9WrtxBSgQ8t85pUVUIdwmvRob8RHNx+Msjs/sJAR
        b4fJS/wPwejN8ricF8+I8Q==
X-Google-Smtp-Source: APiQypI0x3jx9SZb8P1U1DQrg/7KucnaGUh5vJbc18wmIFhWNsPBtOX/RqR3CuKAN5nfN9/vl68rEQ==
X-Received: by 2002:a05:6830:1d62:: with SMTP id l2mr12953583oti.316.1588886458200;
        Thu, 07 May 2020 14:20:58 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b19sm1719349oii.1.2020.05.07.14.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:20:57 -0700 (PDT)
Received: (nullmailer pid 17608 invoked by uid 1000);
        Thu, 07 May 2020 21:20:56 -0000
Date:   Thu, 7 May 2020 16:20:56 -0500
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
Subject: Re: [PATCH v4 06/12] PCI: aardvark: Add FIXME comment for
 PCIE_CORE_CMD_STATUS_REG access
Message-ID: <20200507212056.GA17548@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-7-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-7-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 10:06:19 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> This register is applicable only when the controller is configured for
> Endpoint mode, which is not the case for the current version of this
> driver.
> 
> Attempting to remove this code though caused some ath10k cards to stop
> working, so for some unknown reason it is needed here.
> 
> This should be investigated and a comment explaining this should be put
> before the code, so we add a FIXME comment for now.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
