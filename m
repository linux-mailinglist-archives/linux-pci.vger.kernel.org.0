Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5574E1C9CF9
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgEGVHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:07:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32831 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:07:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id o24so6535843oic.0;
        Thu, 07 May 2020 14:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dsGsWV+BrQRP44t2YAIUJnoLN3cYFR1skM5fepQbKVE=;
        b=hKvZOrZhCEtQZAx0qdp95uJiav6uQCgAyByiMWTv1/oH1Som/L43QMdnYFJcgjFdut
         Qt6z/t9tCAmB1RgB0dScLsyxrbUd6ll3vTPKlLM3SaeupJ7fN019D6ggJ3Aa8EH7aizb
         J9CUs750Ku4xQ9e8IkvOKBdQ3ZMKSb2nfeLq/m7PYJ7KvodvXEHIPCRGRNkfNklIqBlk
         ocKxjbuFNe2gtoazAG6TVDsDv2ok3cZzv1/rd+Y9TreX/I+fGcC/tYYJJyodjfdC4iX+
         q614dVrvhwoWZfzggOpJtqto+Tip0AlhNJ02M90UoYGIeLUMY3B9J4gbnebxl/sFq+qF
         rCZg==
X-Gm-Message-State: AGi0Puaj3PIE4CBlXqyLPgX+cq6ByEjKPlMzWuxXewc+eJP9lT9KMXXg
        J85yFMXqEFcwHcutF36hDQ==
X-Google-Smtp-Source: APiQypJE1YfX89s9+TxW8PhnfeaTupT2fbeq1ECmtPY+Ea5EzwFBQ43rrfRk8hfWR/NHsNdVm7ygkw==
X-Received: by 2002:aca:a954:: with SMTP id s81mr7850669oie.165.1588885658026;
        Thu, 07 May 2020 14:07:38 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q187sm1643480oih.48.2020.05.07.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:07:37 -0700 (PDT)
Received: (nullmailer pid 27626 invoked by uid 1000);
        Thu, 07 May 2020 21:07:36 -0000
Date:   Thu, 7 May 2020 16:07:36 -0500
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
Subject: Re: [PATCH v4 03/12] PCI: of: Zero max-link-speed value is invalid
Message-ID: <20200507210736.GA27591@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-4-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 10:06:16 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> Interpret zero value of max-link-speed property as invalid,
> as the device tree bindings documentation specifies.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
