Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF61C9D37
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEGVYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:24:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36025 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:24:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id x7so5657453oic.3;
        Thu, 07 May 2020 14:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mDXolm6iZ733M48u/HXZ2xjvw7OsZxr5Jn1VStChtTo=;
        b=CmzUAbfG5ZgqgwhzxqdLvZOk8Bbd78LnicZ+JkO1ZAnI4vRNldKLqIunKknmWE0leu
         405mMf4Y8zHy7tkr7335uw6Uc+LdYDDpyLwqZ36oz+NslTuT7bUUnxKTMklqhPxhDmVz
         mZ/8oFYozrMsxEy0CqKmH2xLOur2BedD/xoXsESE7gO1lBV+ZAKref4MKrkjPRqgEmab
         KF79HTLHnlbJ93bIGE3EPZKrj7J8S45+M7hih0XoEKQuAezGBFdHpezz0jutPRkQf77T
         XZ+BEzaNRlSGGI9haWvDV1g3szYk9DUjXMe01OaK+NM828lF4NiYk85BHFDRT/kTBNW2
         89Fg==
X-Gm-Message-State: AGi0PuZVJr1MvLYwsEsYrkpIiaXdxZO8TFxvOa4T73IyJYrmUiP+8A7n
        jeJUP9cIZGjUkWehs8O+Mw==
X-Google-Smtp-Source: APiQypKKqJfMnM1Ip/+XR1s3YlltvCJekEqerjn7XDOrC43sW/SMYdrVIRRleAlY6VdT7ccQH/TcZA==
X-Received: by 2002:aca:fcce:: with SMTP id a197mr862441oii.32.1588886680910;
        Thu, 07 May 2020 14:24:40 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c25sm1625571otp.50.2020.05.07.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:24:40 -0700 (PDT)
Received: (nullmailer pid 23968 invoked by uid 1000);
        Thu, 07 May 2020 21:24:39 -0000
Date:   Thu, 7 May 2020 16:24:39 -0500
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
Subject: Re: [PATCH v4 08/12] PCI: aardvark: Replace custom macros by
 standard linux/pci_regs.h macros
Message-ID: <20200507212439.GA23897@bogus>
References: <20200430080625.26070-1-pali@kernel.org>
 <20200430080625.26070-9-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-9-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Apr 2020 10:06:21 +0200, =?UTF-8?q?Pali=20Roh=C3=A1r?= wrote:
> PCI-E capability macros are already defined in linux/pci_regs.h.
> Remove their reimplementation in pcie-aardvark.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 41 ++++++++++++---------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
