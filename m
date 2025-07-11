Return-Path: <linux-pci+bounces-31964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ECCB02733
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 00:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CC5175D5E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AA21EB5D6;
	Fri, 11 Jul 2025 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVE9Djw3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E66BFCE;
	Fri, 11 Jul 2025 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752274404; cv=none; b=CmfdaqhM6qtdzx42GauizLnKFXjOEGXcNepO4xXaPkbMGtkFELsSqsQAjH+1468qbEolnIGjToqm6juKyepAwCELBmUYbflCT0YKW3SCUNfesHy3c3fiuscXrwDJA8JKYFkvRmfMQc6p3Tu6FPHju3ZlNK7PCX63/fllDiRNsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752274404; c=relaxed/simple;
	bh=Dce+jjWbrq9nliEsy0qLQENP2zNYFENdhnn90MXxnSE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ptMuoinCzO/E8u04EhC9SOWVFbGK4BxnbCRAnpUR/QtWUcRgGUXLzZhrG7wYcc5+T/iBRn7G2z3kX1Nu5+ld7MMoPQnUEgEGsOKPxy/WV/ooTUIH+7lFHb+Z7tALgLUqOXmqxR5bTkFaVoiURK+dj4Ey3d803crAavc4F0qq0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVE9Djw3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748d982e97cso2373568b3a.1;
        Fri, 11 Jul 2025 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752274402; x=1752879202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtNC6XkkO/jON8C2oec+eMDF/ZX7E6/nGcX0kOFU6yY=;
        b=cVE9Djw3WR7zlZT90CgB3aLnJ+DedYQte4bs9MEn1FVM9ileI1qFggTzAYzr7Ytkga
         Ppr29CBjm7ZSwtMYyl+BmwPRcQtvmCYC/O4pIAyNsnpw+NAOg+vpeNF9GeUD0Hpia/T4
         cFJGEq91fzHPI0KLJYCWncNqqGCefv68KUihZgfi2q0CwBNIEw6ATR82sspUh2Xhh/bk
         a01n1DgLQJV3ycci8exmaoiGsgJ3eSJC9+PhdONv8F+35A/s1cRAG/9MbMfyW0Q5Y/Z8
         0MQ2qx6ffM/nGP/HSEZ1baEBAi+QDg3AJnC9mFvJny/JS8ihphoi7pX22g/hwYfpPYPE
         S2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752274402; x=1752879202;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YtNC6XkkO/jON8C2oec+eMDF/ZX7E6/nGcX0kOFU6yY=;
        b=bk9+xsHDc+roqIoXmqfbsUa4YPtt5znUx7tAA/w1oM40+2CqLm3tthvbciEx28J6+8
         Hz95gNBdKSEVC2cLTOqlyZJadxNHyhJFj6hed9UR2DB7BkHZCX8iFLPVpAtEycGtYGLs
         dXYGfbEeX7EXRzNKEr2lm0kbUbtreJ3hXchHNQQJUS634qoA3PQXaRQze14636B53VWL
         GXaXtrsHwAjK1mWpfBZKLZ8O2J1lbv5kEIBwIm0eS7tBdp1EHjng5iKGCpdsVLhDEIod
         sAURNhM1xqPHKyIG+B7jhEkpP2CQTdzEtE76padIFcioPwxban+lM+4k0Ew68ieaBPie
         2QAg==
X-Forwarded-Encrypted: i=1; AJvYcCW8hsO+vhN2Xf4qs13eGJcRlt4ZEB4zIpWBIa/g6y0IYN18ons3+r6z+Bl3GYfsoljeC3aER6QSGGeNt0Pg@vger.kernel.org, AJvYcCX2veo+IUw98j8jRFQd9JXUV+DX0kDRCGmKhr051Dn0Eet7UIuiVsKJvsrlEfXx9Opy+N5DrbU5@vger.kernel.org, AJvYcCX9YcQZsqgbh+tftUY6ZGEMDaEjfzufj2A5I+v7DJesx/rpV9yKW7hnPIi3TZXqTujHNl9Mou73WuWq@vger.kernel.org, AJvYcCXYgcIwrFpHYvDF4Cb+k1o+4dbHL1M6V1Y4+yuW5Imc6ReDc/Xk09jz7Vdnbn+AFpcmX5fifpzBhGkj@vger.kernel.org, AJvYcCXtPBzd/ISa5YBoZOn9ICILPbsiSo73M7ODIJ7fnABssvkFnB9TCofMhS+oDrBtQnldXwOwSW/Ml8e/bA==@vger.kernel.org, AJvYcCXys2xQQCCVXgeEXqRfcpTF+aal14Fbpnc41lZELyPVPBMg2Bu/W4LlqMKckiuJpWNuSqeEWAVO++MOb2d4+tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhIUOEgOUrxzqLKiUXuCAgW7VsebBQYNQJqTLLzjDcWtme4n0
	WLaIFs3JRDt3p7fBiNBk4yvPBGjNbWgfxmVHtMJyXYBEwZHytPkbOpP2
X-Gm-Gg: ASbGncsTwYr1vbGqxpt5IXYrCbNcj/r0PEVOVfsUl2yams9aZcAHPr4jtbjLNdkaH36
	gjyLIFFCdxey+tmxQxJAL7lx6wvsZqShcYC5+t3zNSfT/zIxJnq+Pxknj07sd98x/N9fhXog+lE
	NrObAZJp5MGJX9nd/vLvZ380CmuIv78a36IasxQUGeAxSb4MUe2ceIug6ViUSA5CYTRYbFacFjr
	OfxES3IgPuEMXwfotuBQufK5TJWk9qR7mE1OxCYq47SbeAdUOSTTarIaHh1JwNObOV487spk/2P
	yCE+SWOenPT7nrR8ftSig6EXtoFmzV+D2fE2yFQxdtfiR0NEsXZtKna0jZWp6ae5XyqNzoXSsQO
	okG/QDK/LZZoxwQgkWs7G6PZLC5TdAXtuiiSKoQUsZc0J6PRc2MKbiQuUS+BEdx9VNPiSyHk34F
	+v
X-Google-Smtp-Source: AGHT+IFZEQKk5zMLg8zX6aCQinn3vPgxwhVf4C1XvTSJbDH1J4csn2qqped+eTtejLbHorSkHbd8lQ==
X-Received: by 2002:a05:6a20:6f03:b0:21c:fbf0:21bb with SMTP id adf61e73a8af0-2311ee4b155mr8323398637.24.1752274402391;
        Fri, 11 Jul 2025 15:53:22 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f56a9sm5620815a12.59.2025.07.11.15.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:53:21 -0700 (PDT)
Date: Sat, 12 Jul 2025 07:53:05 +0900 (JST)
Message-Id: <20250712.075305.1992034457870738678.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com,
 gregkh@linuxfoundation.org, ojeda@kernel.org, rafael@kernel.org,
 robh@kernel.org, saravanak@google.com, tmgross@umich.edu,
 a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, david.m.ertman@intel.com,
 devicetree@vger.kernel.org, gary@garyguo.net, ira.weiny@intel.com,
 kwilczynski@kernel.org, lenb@kernel.org, leon@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lossin@kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 0/3] rust: Build PHY device tables by using
 module_device_table macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <83b1b2f4-f87c-4b3f-ab4d-84ec429abd79@kernel.org>
References: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
	<83b1b2f4-f87c-4b3f-ab4d-84ec429abd79@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 00:19:54 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> On 7/11/25 6:09 AM, FUJITA Tomonori wrote:
>> Build PHY device tables by using module_device_table macro.
>> The PHY abstractions have been generating their own device tables
>> manually instead of using the module_device_table macro provided by
>> the device_id crate. However, the format of device tables occasionally
>> changes [1] [2], requiring updates to both the device_id crate and the
>> custom
>> format used by the PHY abstractions, which is cumbersome to maintain.
>> [1]:
>> https://lore.kernel.org/lkml/20241119235705.1576946-14-masahiroy@kernel.org/
>> [2]:
>> https://lore.kernel.org/lkml/6e2f70b07a710e761eb68d089d96cee7b27bb2d5.1750511018.git.legion@kernel.org/
>> Danilo, I incorporated your fixes into the first patch and mentioned
>> them in the commit message. Let me know if you'd rather take a
>> different approach.
> 
> Thanks FUJITA -- no need to mention it though. :)
> 
> Did you forget to pick up Jakub's ACK or was this intentional?

Oops, please add his ACK when applying.


Thanks,


