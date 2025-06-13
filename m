Return-Path: <linux-pci+bounces-29684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B9DAD8C15
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA801757C2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE542E175B;
	Fri, 13 Jun 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMscSHKJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B62DECAE;
	Fri, 13 Jun 2025 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817727; cv=none; b=iuJrJWFtRA/Yx3SAVFCqY8BEotKl7r4fy5UOsf5F4ccfj0/Ca1pZbEbwMeBhkL2e5co7fBR7cvXke7A53lHYvd/g4cIirxWxESKYXSGSbsXE3rij6hCFdYuiopaDxMnTGRAYvFTuL92q5zY6VJFTqQHba59jyGNH2fdvkMMeLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817727; c=relaxed/simple;
	bh=ZGX+7HT2TeOEyJhZBicdeJ7zo7lI8UGljjytma27f8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrCmxeL8VV+vhDEjpzV3k6PE1paaZi1VMmBbdk9hD8n5zGFbL5h2ePNMzI8cC2M/9ct003htKmKTdkhxAENKu2KbtVUwnzT6IA3YaKEJzsYMYJ4oGIXFLuwLISy72+heqzqiMcelq1XskyrKorAhDceiVQs2gUpE4JjAl1QoOZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMscSHKJ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so2267861a12.0;
        Fri, 13 Jun 2025 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749817725; x=1750422525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUheJAvJ/QAI2j1ArBPoXkPiiSX0R8DUeLQ8vjaGCHc=;
        b=PMscSHKJ6WfDZ0n6BGvboIkXgJgvt8v5lNduSdPNDeoiZejMkn3zbp0A4b9B32bEIl
         NEiL3stjUWkY6CDCgHTxVDQtCHV0L9FzwwlcQHSbAFJD+D7yMOJln9sSmrQ90I6xOCFo
         vI5b/BYTFslW5za5UnlGy66yJArYmPziv77WQn+XR87gScqtDgyRpP/+2UdBEwyWqKzo
         sy5LubBirpX5koP6q6H7k+nbXvrc+WICQPuaDmNOItSsiEVyE89w4KAw9VZnG52Gc1OH
         PBMcb3kaBCZG3+gl6ddWp9oGPM2m051bbc+0WSJ/dgx1OG88kPhMPlivVLJMJnYi9AU1
         W4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817725; x=1750422525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUheJAvJ/QAI2j1ArBPoXkPiiSX0R8DUeLQ8vjaGCHc=;
        b=dLgwC+2P2lUn02oQg/4OW9pd43Jpjj/u9L0A8f4XNa1MyCLF4Sc65S7JYjBf9Qk950
         EdwVAKuxUCDEf3aeIFgf64NxCXaghdsGEaEDauweguRFnsD99f7cptD70jAhPF28Mcdj
         GBol2A+kB4IJ2/lAnM7+slNA2p/z4f7EVielZrYn4Gx8hGAHmzpd8tkdk9IGytSBoxWK
         y91G1zrYb3EX+Cg45X3wBavbcAZRgakcvpvhIUoBgo4LHIfrJ2EZSpnN9mteGBt3zHwI
         3wVZYOi493o/j8muXP4wqDDozkldfLL4and+Tftr97p5BTauwcbfxUG1NwYpFifv7R7K
         4lSA==
X-Forwarded-Encrypted: i=1; AJvYcCU2L0igrA1udgFRKPyiQprlymJQ+qnausq8L94P7Jq80E49VktCuq+WeiQ0wKQRdUguXa3SrtCAJZtyHG4=@vger.kernel.org, AJvYcCUWxiV7m8nEYO8WpiSg+p7fYsUgXDhEy5q3U3oZof0QGVlODOIxyqqNPK6qbr7rFCeJrINXU9/5@vger.kernel.org, AJvYcCUikTWrjNJpAZZsKhDQ3VRS6cxspb7ebOALkgooa9K43eDegAtNvDRGXsTg3R+K1CnO5zucD9gWWk4d4DXX@vger.kernel.org, AJvYcCWTaTv7wDYtd85kE2V0Ewh3EQuhuQeef0cHzUi1kSobA3Vab6uK7so6ru5wp9QQlg8UVgAJSpgamq/7@vger.kernel.org, AJvYcCWerjOM/bto2v9G1CuODbcSmSc18plfEhWK0qyWAuQ3jxBtw6sNKIuNSELDuiB5XOJQ/QfkdlCn3m0=@vger.kernel.org, AJvYcCWqTizQWP+mgWYhtvkJX19s610xXk3BKTAjIiAVHzzORSVq9wpc/B3hXfl68O6wdvWpAExQfS/sfLxt@vger.kernel.org, AJvYcCX7hjFBUf2nB2k7WDnfYc05rviOp2F8xSJjxB9gBGQsOJRSjgcNGnKelrKTOXDlxVC2K7gZxazx0uJOTts=@vger.kernel.org, AJvYcCXQMoKwLq5J3TR8A42ll0bN5CDdmo3nBuV71c86DBkd6AvuXQPYXGDaHMnXbaTQcsxg7FFE70H/svs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMChjTBdQ5WiLjIsVi+B3haReL3PrBiNF3O1xL4hdEhBA+jvF
	5gc0lOUqT5CnsgODPAyM2iOsNNPLlY8OEWOFZzkfcWXY0/Cgl2EMRBP7
X-Gm-Gg: ASbGncsFY75gMkdIDssEqdgqJKzuqhbxEzB5SQq85YXsNtYDjQDoku2xC/8Iuwu7eDA
	KXg3eSn2S0WIArderRknotHgGEEkXSoNNVceJuvw/E+HNPFdZSxD79InI/Y68qttwcMdTZ0U0jT
	/yx12N7wEU7sy46nfd+pMbA3l3yOgDxvalpC3wgSdYHjDXJtYVBjO+4XL3ulNLKMlL3pnIbNGxa
	Qc2GIWqDbwdv9XS6qmf8IFIj7Mzp6SJ3ydxexXlqnVMaVMB645iUYp69XWYuo7Q2ZzxZFhG1UXf
	dkbTSLsKZyM8fgESoFs6ULQHkDvCj+7dA1mU5TfbxEdLYG1xUknslc7x5WFDdQ==
X-Google-Smtp-Source: AGHT+IE+gcmD/PmavjTCsZJ5Ebw+bwtrBwmaH3AIBOuyUnFsBAjlI4hGAFjqzUYV1uUOPvmBym85Fw==
X-Received: by 2002:a05:6a20:9151:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-21facbb40c3mr4162006637.11.1749817724606;
        Fri, 13 Jun 2025 05:28:44 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1644c92sm1565073a12.32.2025.06.13.05.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:28:44 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:28:40 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Qin Jian <qinjian@cqplus1.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jani Nikula <jani.nikula@linux.intel.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
	llvm@lists.linux.dev, Tvrtko Ursulin <tursulin@igalia.com>
Subject: Re: [PATCH 01/20] bitfield: introduce HWORD_UPDATE bitfield macros
Message-ID: <aEwZcM_leVvB0Cju@yury>
References: <20250612-byeword-update-v1-0-f4afb8f6313f@collabora.com>
 <20250612-byeword-update-v1-1-f4afb8f6313f@collabora.com>
 <5493fd6017de3f393f632125fad95945d1c4294c@intel.com>
 <3683577.irdbgypaU6@workhorse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3683577.irdbgypaU6@workhorse>

On Fri, Jun 13, 2025 at 01:55:54PM +0200, Nicolas Frattaroli wrote:
> Hello,
> 
> On Friday, 13 June 2025 10:51:15 Central European Summer Time Jani Nikula wrote:
> > On Thu, 12 Jun 2025, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> > > Hardware of various vendors, but very notably Rockchip, often uses
> > > 32-bit registers where the upper 16-bit half of the register is a
> > > write-enable mask for the lower half.
> > >
> > > This type of hardware setup allows for more granular concurrent register
> > > write access.
> > >
> > > Over the years, many drivers have hand-rolled their own version of this
> > > macro, usually without any checks, often called something like
> > > HIWORD_UPDATE or FIELD_PREP_HIWORD, commonly with slightly different
> > > semantics between them.
> > >
> > > Clearly there is a demand for such a macro, and thus the demand should
> > > be satisfied in a common header file.
> > >
> > > Add two macros: HWORD_UPDATE, and HWORD_UPDATE_CONST. The latter is a
> > > version that can be used in initializers, like FIELD_PREP_CONST. The
> > > macro names are chosen to not clash with any potential other macros that
> > > drivers may already have implemented themselves, while retaining a
> > > familiar name.
> > >
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  include/linux/bitfield.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > >
> > > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > > index 6d9a53db54b66c0833973c880444bd289d9667b1..b90d88db7405f95b78cdd6f3426263086bab5aa6 100644
> > > --- a/include/linux/bitfield.h
> > > +++ b/include/linux/bitfield.h
> > > @@ -8,6 +8,7 @@
> > >  #define _LINUX_BITFIELD_H
> > >  
> > >  #include <linux/build_bug.h>
> > > +#include <linux/limits.h>
> > >  #include <linux/typecheck.h>
> > >  #include <asm/byteorder.h>
> > >  
> > > @@ -142,6 +143,52 @@
> > >  		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
> > >  	)
> > >  
> > > +/**
> > > + * HWORD_UPDATE() - prepare a bitfield element with a mask in the upper half
> > > + * @_mask: shifted mask defining the field's length and position
> > > + * @_val:  value to put in the field
> > > + *
> > > + * HWORD_UPDATE() masks and shifts up the value, as well as bitwise ORs the
> > > + * result with the mask shifted up by 16.
> > > + *
> > > + * This is useful for a common design of hardware registers where the upper
> > > + * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
> > > + * register, a bit in the lower half is only updated if the corresponding bit
> > > + * in the upper half is high.
> > > + */
> > > +#define HWORD_UPDATE(_mask, _val)					 \
> > > +	({								 \
> > > +		__BF_FIELD_CHECK(_mask, ((u16) 0U), _val,		 \
> > > +				 "HWORD_UPDATE: ");			 \
> > > +		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask)) | \
> > > +		((_mask) << 16);					 \
> > > +	})
> > 
> > i915 uses something like this for a few registers too, with the name
> > _MASKED_FIELD(). I think we could use it.
> > 
> > I do think this is clearly an extension of FIELD_PREP(), though, and
> > should be be named similarly, instead of the completely deviating
> > HWORD_UPDATE().
> > 
> > Also, we recently got GENMASK() versions with sizes, GENMASK_U16()
> > etc. so I find it inconsistent to denote size here with HWORD.
> > 
> > FIELD_PREP_MASKED_U16? MASKED_FIELD_PREP_U16? Something along those
> > lines?
> 
> Yeah, I agree the name could be better. I used HWORD_UPDATE as Yury and
> I couldn't come up with a name we liked either, and Yury suggested not
> breaking from what's already there too much. I do think making the name
> more field-adjacent would be good though, as well as somehow indicating
> that it is 16 bits of data.
 
I suggested a wonderful name that explains everything. Didn't I? It
has the only problem - it's 25 chars long. :)

So yeah, let's think once more about a better _short_ name, or just
stick to the existing naming scheme.

> > And perhaps that (and more potential users) could persuade Jakub that
> > this is not that weird after all?
> 
> I will operate under the assumption that Jakub's opinion will not change
> as he ignored the commit message that talks about multiple vendors,
> ignored the cover letter that talks about multiple vendors, and ignored
> my e-mail where I once again made it clear to him that it's multiple
> vendors, and still claims it's a Rockchip specific convention.

As far as I understood, he concerns not about number of drivers that
opencode HIWORD_UPDATE(), but that this macro is not generic enough
to live in bitfield.h. And it's a valid concern - I doubt it will
be helpful somewhere in core and arch files.

I think that creating a separate header like hw_bitfield.h, or hw_bits.h
aimed to absorb common helpers of that sort, would help to reach the
strategic goal - decreasing the level of code duplication in the driver
swamp.

Thanks,
Yury

