Return-Path: <linux-pci+bounces-7630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41678C8AA1
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29AA1C21FD7
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0D13DB88;
	Fri, 17 May 2024 17:12:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957013D8B9;
	Fri, 17 May 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965938; cv=none; b=WqcmmQ5BvrN5uORvEi3hckPdd5AxJnuTkjk+rmXKeytryMBBwK6zdi/eVQ3GSG9MhkiftyaLjNdHobTg36H7oxejyM3EdtDOSvIv0gRhUQPnJxJx5vR2VEFm/xzVJ8iqXbhcjlCqpuY7LTVn92UJ8xvadJqKer05FoOT1+l5cis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965938; c=relaxed/simple;
	bh=V7Moi5gWFU3OYOWp1ODvyUp0cpccJTi4lzeR8bBjtxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TArLqOkx5p9i9RFaM/R13vFXnZuLfUCzju9K3OwFyzGicPWGslOoRzM2RTfxqHWqzCFKTekbzr71ZlMki+mVUeXGCCtY0fjfiDl/8gBk3Sm9UGFZWN9rXhjgMSOa45WmZucT+YWwuK7RZtygjuG3ks2jHq4rlLuNVMdD0rFk7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so90824a12.0;
        Fri, 17 May 2024 10:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965936; x=1716570736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJP3Bvi4LZvT2V50/zdiKAgCKlmfC4y7jjdKq6zUFW0=;
        b=bxOSrHTCPlneyUptUHRlx+YbJTqKK/J7pSpxOgypsUogf7eMGFSHI8ltP72Lbf7Cu2
         X3iocQhu35dVNzNZHQCBMeuXxZuw6D+BpoJhkFkTn8XMjyBnbx2pIr5E20M1ht+pksE6
         zx6WI3nEfg4f6LCDjF83DjdXqLgUt2ZFnlaf4jaYtx8YVFe/VO18CFSkkLuGEyjZ544w
         0sKgUESGUkICPHc2dylyWgIePv1KzsrtaO4ZT/LQKoBfLGqkdb45YBs88c2krVknKps2
         wfm5ge6rDDWNdmZC3mqqvVeL718etRF+wD25ijXPN1NAMaZpAOQkdGAHGNh8dJ7N7TuZ
         wHdw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7Wl6cyxr1xoMeshLiNlZzMtIo5KcyflUEt3BP2IZINNoMFdJvd481TK2XTybHlyahka986XSileTXi7g7kKtDFvUDjtwnCffb3k3tZyQKRpRNy/+Qp5KepfbaaGQxeMOYJW10YnaBgCgFyvrrxYW4c8iCGoD95V7QHSSj8zNyx3gqQ==
X-Gm-Message-State: AOJu0YyQRqM1RTD60IE3llmL6j1I5eGJ/req8i0FlURmo5C7zduUEhgk
	LGrezRbrDMvSR1C6vFOL6yWTnjlQ+Um2t0WQQ0j58qMhDsJdAH3Y
X-Google-Smtp-Source: AGHT+IERiv3eoMFHKpAJyk5tOavTPrH9L+4rFoAlwWFeIVmvoquPL58lrRrbGXcz8+OzDTGfJm4bUQ==
X-Received: by 2002:a05:6a00:21c6:b0:6f4:9fc7:daf2 with SMTP id d2e1a72fcca58-6f4e02a5f45mr26551627b3a.7.1715965936009;
        Fri, 17 May 2024 10:12:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b57ed97sm15246657a12.23.2024.05.17.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:12:15 -0700 (PDT)
Date: Sat, 18 May 2024 02:12:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v8 0/5] PCI: dwc: Add common pme_turn_off message by
 using outbound iATU
Message-ID: <20240517171213.GE1947919@rocinante>
References: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>

> Involve an new and common mathod to send pme_turn_off() message. Previously
> pme_turn_off() implement by platform related special register to trigge    
> it.                                                                        
>                                                                            
> But Yoshihiro give good idea by using iATU to send out message. Previously 
> Yoshihiro provide patches to raise INTx message by dummy write to outbound 
> iATU.                                                                      
>                                                                            
> Use similar mathod to send out pme_turn_off message.                       
>                                                                            
> Previous two patches is picked from Yoshihiro' big patch serialise.        
>  PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
>  PCI: Add INTx Mechanism Messages macros                                   
>                                                                            
> PCI: Add PME_TURN_OFF message macro                                        
> dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
> to map PCI msg.                                                            
>                                                                            
> PCI: dwc: Add common pme_turn_off message method                           
> Using common pme_turn_off() message if platform have not define their.

Applied to controller/dwc, thank you!

[01/05] PCI: Add INTx Mechanism Messages macros
        https://git.kernel.org/pci/pci/c/182e6ef0df77
[02/05] PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
        https://git.kernel.org/pci/pci/c/523d5018701d
[03/05] PCI: dwc: Add outbound MSG TLPs support
        https://git.kernel.org/pci/pci/c/a683a0065ac1
[04/05] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
        https://git.kernel.org/pci/pci/c/a61a1c5932b0
[05/05] PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend
        https://git.kernel.org/pci/pci/c/33af7f463b68

	Krzysztof

