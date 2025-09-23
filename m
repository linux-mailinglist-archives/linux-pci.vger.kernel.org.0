Return-Path: <linux-pci+bounces-36784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498DB96CD4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360B94425FC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5E320CCE;
	Tue, 23 Sep 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NQ5Biita"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643932144D
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644504; cv=none; b=j0vXRUQgQE1AzoFeQmJSBQyzaAcOa0C0O5j7+kn8PmSXM38BLQrca9RGb22MRXNHP4E5LDX1Pxo5CuTcHncEkPizuVYH6xgJqF9CKJ4ImF+oPbclgh1C8zK9DpwzEX4A8oXUvt50sDJAk9wtLtPZGw04NTaURiO+KNGdU8cAfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644504; c=relaxed/simple;
	bh=IYKsjA2lVzqlmST6yIaoy5ZiKBNubcdQiY7wDAQazvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA8VEGc46ErdYF9T/o4IT+tc3UOzBjAk4SDe/mYSVI4BsFiAZYU1/pKD/g6J1yLq3f3qFe4UGx1aNEaDOjj8t9e1VdYCoo0zpVBWV0z2FrRx5UWCO3DcavPNt/qBQ0pCmvMG3qSitaYRBVU4z5kR9boMLwQ92w6jpF7fh3bALss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NQ5Biita; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-82884bb66d6so5585185a.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758644501; x=1759249301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAF1ZqvUCq+DYRKtNmDJLT3lAtr/qrJIjSppUMh/0OY=;
        b=NQ5BiitavknQtMTIHry7kXzwAhCnm7ekaEDkBQOfkzdWU2FazwN2WwicMzfKjL147F
         zAtg6XJ4RjqdiucR5HR3qSAcd2JxGMZMBgSG6d/wKRbW04OCsOTYn6qM2o1wcU9MOmHX
         AFvekpOTqH/fhgCMk4p+xPDh2JqFQa65h4FZ9oep6oXITiku4hdLJc5a/JABRW2Cpla5
         1ZkmiGe5LWRNsAVxrFhtLvcAOgxbLd0mjHsGROY0CDJbvOoeUSollE/0h1KEvQURMw6V
         ghPgfMXGFWzWfr83Pi0qY0MwRmfIiE0VDcLY1rAnap/lzRBhVqP8aaVBIHPIinJsGCYF
         Dqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644501; x=1759249301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAF1ZqvUCq+DYRKtNmDJLT3lAtr/qrJIjSppUMh/0OY=;
        b=xGcgFXzSX+R0HioZ1viMENphCYgxig9cWCIlsFDgbBcbcBKAm72qjPSTGNUS128gRs
         g0/aDbiZlCPMPbewXFziqwQacTqofum5yxtdl5cBymq13uP48IqdkpDpQ6GrU+hvs7IE
         Ke16EDUtvCppEq7XqNzcZ1DA8KhY+sFPJfKD9wQIEb3dKmfawr4cCw0NlBtWiP01qZs9
         m/xwhDIhJhwg7SPlXucgQMI3EQ8T3D936eVZDZtBtXToBOD6c/xBhEHpDfyrVc87ZBte
         C5HQYVzYBMCdLuXyc21aCefFckhal9o6J9JKk+1Cn4uN8OJcpYVPP2PtGf0U0Z/SVh5j
         Kzbg==
X-Forwarded-Encrypted: i=1; AJvYcCWoAVF7I4xS5c1KX+VUCFiulKQY6OKIZ8X1/keTPSJ3Q2bQHjBo4Bub06JHrz8rDSESbRmof7gN8fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXMRXMmzA17bnPHy/je3N5jS7s0Ln0E3Ig5/ovgrlu+xiPDjV
	UZim+unf7m5sbxEze++HkToZZtuhY/rym9CevK0YoznmiZwflQ5LRIy2fS+efZwTFag=
X-Gm-Gg: ASbGncsW50yEKWqbS5Mq01RDKAeAdr418twzYbsB0K2fUfuZyBJ0g8yfRo+HS9IYfq0
	yQPsSNDsMoEWDAdNoOwaE4TcMJnsP2YbVXVWWEToRxjwjIef4EiTJxLupT8Km5weACtp36kAYeX
	0lMbg2f4PAAxwkwZD3cVGtGbETGmeBQ606KBAyI5r2OQmK4FJzJ9m2jVpYfTrH7PxAleOVEMRbH
	60PWqn7vxrDhE6IopfmJrimicgTzEH1Ep2SFv6LSRK2vGazBEc2gA8NusQhl/RAY5xY03rvLBX6
	BSjwSamLMXME8jyuxauKN8jZlQkTPVDv+loHSZnlsJ64My58OAwWiWuv6PRUeZPH0GYyo3O9
X-Google-Smtp-Source: AGHT+IFYjLvlYVWkvRmfrd4O74XRQ2yOeConI9WiorD7CA02H/AscVNhWnASnvsfS0ugaprQj9f5qQ==
X-Received: by 2002:a05:620a:7088:b0:84f:e093:3949 with SMTP id af79cd13be357-851b8ba216bmr341372285a.36.1758644500700;
        Tue, 23 Sep 2025 09:21:40 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84cb88e6969sm318223985a.2.2025.09.23.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:21:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v15lr-0000000AxbL-2Bdg;
	Tue, 23 Sep 2025 13:21:39 -0300
Date: Tue, 23 Sep 2025 13:21:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
	Anders Roxell <anders.roxell@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Fix ACS enablement for Root Ports in DT
 platforms
Message-ID: <20250923162139.GC2547959@ziepe.ca>
References: <20250910-pci-acs-v1-0-fe9adb65ad7d@oss.qualcomm.com>
 <20250918141102.GO1326709@ziepe.ca>
 <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tzlbsnsoymhjlri5rm7dw5btb2m2tpzemtyqhjpa2eu3josf5c@uivuvkpx3wep>

On Tue, Sep 23, 2025 at 09:07:49PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Sep 18, 2025 at 11:11:02AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 10, 2025 at 11:09:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > This issue was already found and addressed with a quirk for a different device
> > > from Microsemi with 'commit, aa667c6408d2 ("PCI: Workaround IDT switch ACS
> > > Source Validation erratum")'. Apparently, this issue seems to be documented in
> > > the erratum #36 of IDT 89H32H8G3-YC, which is not publicly available.
> > 
> > This is a pretty broken device! I'm not sure this fix is good enough
> > though.
> > 
> > For instance if you reset a downstream device it should loose its RID
> > and then the config cycles waiting for reset to complete will trigger SV
> > and reset will fail?
> > 
> 
> No. Resetting the Ethernet controller connected to the switch downstream port
> doesn't fail and we could see that the reset succeeds.

Reset it by up/down the PCI link?

> Maybe the bus number was still captured by the device.

Maybe, but I don't think that is spec conformat behavior.

Jason

