Return-Path: <linux-pci+bounces-9001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C85590FB38
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 04:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE00282EE6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 02:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23317C9E;
	Thu, 20 Jun 2024 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiASwkGJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361AB66F;
	Thu, 20 Jun 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849723; cv=none; b=sUlf+ZAfuX3vqezf4G9Hl2+DmbC4UKAbPZk2xEAKkL3bptGWURnOPvkX9AkZ2yyIg4u8x6PXp+gytjmeytIB9nyGvWmNqSlMz85El0U439xqerphgWGI1n1AOnj9oohZUZ61KlgU0tDcwGUJeFgyax8lvGnDJ1tEZ6gTq+txk6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849723; c=relaxed/simple;
	bh=eo5Rs2EcLjDRPzkDOB/QMSF/xaaqVWsj76JR/MuKt94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANY4eGEu9lEp5t/YgP6AK0J06ZVkTEofFtxKEvVXjV5CUaLXfuBgbGrIdJsjuI7gurHiiJlqKZyP6B9RGWSRwP3C13BNfPC4pAnSvDlQ/kkAX77+dPpujSWkj1ZKPO1Ol9RV+1mfsnSGGeZ3MTuiHMGW/saIvOZfo5ddwjGs/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiASwkGJ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5bb36de2171so146818eaf.2;
        Wed, 19 Jun 2024 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718849721; x=1719454521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CRUkQdGOKU9OB0MqSqSfhBwPPa2DOFb6bMBOZf3RUNM=;
        b=AiASwkGJXM1eOWFiyylihe6lBUKUsWiIbMHO8amWfNPhFko6qp6Vl9qB5qHWuCuWok
         TS9Xg4JRY4XxfhvY9UMEw0FkSC+9urz2YSSiU1QH93mJNw3L0HPNYJ/vM9J0tlYanXIM
         2f2fxUKnnnmygGWL61hzVV9Iwr9+o0wTPLF7mZAW+zkJDVfE1w6+Bmj1tzA9GJNARKku
         c738yGK8evoKhdEtfPVdK4iHGYasE0iveeGZr/LtazDhbBXElWaEZ/FQambiSrdclnOv
         3idzY/eMSvOlTrTSx4gjsz+ptMd3g45pd7Xz8ueWrgKdqb4mHAk7eYPMjqtNFxddbwxM
         Ti5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718849721; x=1719454521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRUkQdGOKU9OB0MqSqSfhBwPPa2DOFb6bMBOZf3RUNM=;
        b=s9+/+JpSSB89iUca7pVETpCRoy3fdWHD7+VTNe/zddzs1RikxbPN/nh3K0zTWWgr/a
         X6k/8WMSskx7zo/8ejf3yJ98dSFaEJNNFSK3CJdSFgsjVANPcoJZWmH8s6fPoLHzO3v3
         6uA3GQjTPvhxcxsRC3jxrmX5+aImophhNsT6DeB0GcfT5ETlVs8ovJSmdFOkG79Zmi1v
         hbk3tmbLa3Qke0x6lVGjjAIZfWH+WaSGexZ/NkRRyWxrHYXSrEFFQD78OHRbdMoDkC8x
         9iXzhwtgG2QCXS9sy/LHNeP7h5d5aGR33B9xez+Ymcq+9WERjxrgTvvsCh+WwHphDJC5
         zIqw==
X-Forwarded-Encrypted: i=1; AJvYcCU9iggucRU5VSpeGLdy3bLHDfKH8szG+8jrt0koO/GjDDHiNg5og/IyRzLiL0g8hE7V8fBAuaWLW0j7y3QdwPtTNwBRNgpj8Mtwzfxyl7CDBs8zzQvGM5tzzwF0FcUl4zegyccTHmuH
X-Gm-Message-State: AOJu0Yy4BctjvPR53Sncw1OoGzccvp7tpNwGeaswJiqxlRcK5iEC/5+o
	sNK6oeWeUAUqBmrPkxjM06ZNAG4pllg0nWDlqZwHL33zN2VqGFKOdxmb2hGx1QAtQPi0tg8cJnX
	L3khiuXjXXkSi+AQAl9IIULWuqUs=
X-Google-Smtp-Source: AGHT+IHrnG/ArrsWeUTM5kYZ3ewBI2pHcNcWXpk3t2crBp2qN+iBG5ZBkS/qw5d1gUi8Lf5tvzb7mkZ9vhDLpLpIHi0=
X-Received: by 2002:a4a:2513:0:b0:5bb:1310:5f37 with SMTP id
 006d021491bc7-5c1adb1884cmr4687145eaf.3.1718849721163; Wed, 19 Jun 2024
 19:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618164133.223194-2-linux.amoon@gmail.com> <202406200818.CQ7DXNSZ-lkp@intel.com>
In-Reply-To: <202406200818.CQ7DXNSZ-lkp@intel.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 20 Jun 2024 07:45:05 +0530
Message-ID: <CANAwSgS74LOHi+hXQAG9NH5PZ-OA+w21vXtucQagfsNtn-3Qww@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
To: kernel test robot <lkp@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Thu, 20 Jun 2024 at 06:25, kernel test robot <lkp@intel.com> wrote:
>
> Hi Anand,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus linus/master v6.10-rc4 next-20240619]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/PCI-rockchip-Simplify-reset-control-handling-by-using-reset_control_bulk-function/20240619-014145
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20240618164133.223194-2-linux.amoon%40gmail.com
> patch subject: [PATCH v1 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
> config: arc-randconfig-001-20240620 (https://download.01.org/0day-ci/archive/20240620/202406200818.CQ7DXNSZ-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200818.CQ7DXNSZ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406200818.CQ7DXNSZ-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/pci/controller/pcie-rockchip-ep.c:20:
> >> drivers/pci/controller/pcie-rockchip.h:311:31: error: array type has incomplete element type 'struct clk_bulk_data'
>      311 |         struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
>          |                               ^~~~
>

I will try to fix this issue in the next version, once I get more
feedback on the rest of the changes.

>
> vim +311 drivers/pci/controller/pcie-rockchip.h
>
>    298
>    299  struct rockchip_pcie {
>    300          void    __iomem *reg_base;              /* DT axi-base */
>    301          void    __iomem *apb_base;              /* DT apb-base */
>    302          bool    legacy_phy;
>    303          struct  phy *phys[MAX_LANE_NUM];
>    304          struct  reset_control *core_rst;
>    305          struct  reset_control *mgmt_rst;
>    306          struct  reset_control *mgmt_sticky_rst;
>    307          struct  reset_control *pipe_rst;
>    308          struct  reset_control *pm_rst;
>    309          struct  reset_control *aclk_rst;
>    310          struct  reset_control *pclk_rst;
>  > 311          struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
>    312          struct  regulator *vpcie12v; /* 12V power supply */
>    313          struct  regulator *vpcie3v3; /* 3.3V power supply */
>    314          struct  regulator *vpcie1v8; /* 1.8V power supply */
>    315          struct  regulator *vpcie0v9; /* 0.9V power supply */
>    316          struct  gpio_desc *ep_gpio;
>    317          u32     lanes;
>    318          u8      lanes_map;
>    319          int     link_gen;
>    320          struct  device *dev;
>    321          struct  irq_domain *irq_domain;
>    322          int     offset;
>    323          void    __iomem *msg_region;
>    324          phys_addr_t msg_bus_addr;
>    325          bool is_rc;
>    326          struct resource *mem_res;
>    327  };
>    328
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Thanks
-Anand

